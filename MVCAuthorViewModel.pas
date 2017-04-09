unit MVCAuthorViewModel;
{$I Synopse.inc} // define HASINLINE WITHLOG ONLYUSEHTTPSOCKET

interface

uses
  SysUtils,
  Contnrs,
  Variants,
  SynCommons,
  SynLog,
  SynTests,
  mORMot,
  mORMotMVC,
  MVCModel;

type
  /// defines the main ViewModel/Controller commands of the BLOG web site
  // - typical URI are:
  // ! blog/main/articleView?id=12 -> view one article
  // ! blog/main/authorView?id=12 -> information about one author
  // ! blog/main/login?name=...&plainpassword=... -> log as author
  // ! blog/main/articlecommit -> article edition commit (ID=0 for new)
  IAuthorModule = interface(IMVCApplication)
    ['{77D42939-7879-4506-8528-7339D859588B}']
    procedure AuthorView(
      var ID: TID; out Author: TSQLAuthor; out Articles: variant);
  end;

  /// implements the ViewModel/Controller of this BLOG web site
  TAuthorModule = class(TMVCApplication,IAuthorModule)
  public
     procedure Start(aServer: TSQLRestServer); reintroduce;
     procedure Default(var Scope: variant);
     procedure AuthorView(
      var ID: TID; out Author: TSQLAuthor; out Articles: variant);
  end;


var
  aAuthorModule: TAuthorModule;
implementation
uses SynMustache;
const
  ARTICLE_FIELDS = 'RowID,Title,Tags,Abstract,ContentHtml,Author,AuthorName,CreatedAt';


{ TAuthorModule }

procedure TAuthorModule.AuthorView(var ID: TID; out Author: TSQLAuthor;
  out Articles: variant);
begin
 RestModel.Retrieve(ID,Author);
  Author.HashedPassword := ''; // no need to publish it
  if Author.ID<>0 then
    Articles := RestModel.RetrieveDocVariantArray(
      TSQLArticle,'','Author=? order by RowId desc limit 50',[ID],ARTICLE_FIELDS) else
    raise EMVCApplication.CreateGotoError(HTTP_NOTFOUND);

end;

procedure TAuthorModule.Default(var Scope: variant);
begin

end;

procedure TAuthorModule.Start(aServer: TSQLRestServer);
var
   LParams: TMVCViewsMustacheParameters;
   LViews: TMVCViewsAbtract;
begin
  inherited Start(aServer,TypeInfo(IAuthorModule));

  FillChar(LParams, SizeOf(LParams), 0);
  // That's key point: check template modification every second
  LParams.FileTimestampMonitorAfterSeconds := 1;
  LParams.ExtensionForNotExistingTemplate := '.html';
  LParams.Helpers := TSynMustache.HelpersGetStandardList;
  LParams.Folder := ExeVersion.ProgramFilePath+'Views' + PathDelim +'authormodule'+PathDelim;
  LViews := TMVCViewsMustache.Create(Factory.InterfaceTypeInfo,
    LParams, aServer.LogClass);
  fMainRunner := TMVCRunOnRestServer.Create(Self, nil, 'authormodule',LViews).
    SetCache('AuthorView',cacheWithParametersIgnoringSession,60);

  aServer.Cache.SetCache(TSQLAuthor);

end;



end.
