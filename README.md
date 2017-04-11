"# mormot-sample-30-modified" 

Let's translate the message "Sign in" that apears in view: masthead.partial

1. In masthead.partial change {{Sign In}} to {{"Sign In}}
2. we need to find the hash("Sign In"). 
   Run the HashProject and get the result:1964225139=Sign In
3. create a text file named: MVCServer.messages with content:
        [Messages]
        1964225139=Sign In
4. create a text file for the greek translation named: GR.msg with content:
        [Messages]
        1964225139=Σύνδεση
5. In unit MVCViewModel create: 
  TMVCViewsMustacheLang = class(TMVCViewsMustache)
    procedure Render(methodIndex: Integer; const Context: variant; var View: TMVCView); override;
  end;

  procedure TMVCViewsMustacheLang.Render(methodIndex: Integer;
  const Context: variant; var View: TMVCView);
begin
 View.Content := GetRenderer(methodIndex,View.ContentType).Render(
    Context,fViewPartials,fViewHelpers,  Language.Translate);
  if trim(View.Content)='' then
  with fViews[methodIndex] do begin
    Locker.Enter;
    Mustache := nil; 
    Locker.Leave;
    raise EMVCException.CreateUTF8(
      '%.Render(''%''): Void "%" Template - please put some content!',
        [self,ShortFileName,FileName]);
  end;
end;

The only difference with TMVCViewsMustache is passing the parameter Language.Translate

Then in procedure TBlogApplication.Start(aServer: TSQLRestServer)
add:
var
  LViews: TMVCViewsMustacheLang;

and:
FillChar(LParams, SizeOf(LParams), 0);
  LParams.FileTimestampMonitorAfterSeconds := 1;
  LParams.ExtensionForNotExistingTemplate := '.html';
  LParams.Helpers := TSynMustache.HelpersGetStandardList;
  LViews := TMVCViewsMustacheLang.Create(Factory.InterfaceTypeInfo,
    LParams, aServer.LogClass);
  LViews.RegisterExpressionHelpers(['MonthToText'],[MonthToText]).
  RegisterExpressionHelpers(['TagToText'],[TagToText]);

  fMainRunner := TMVCRunOnRestServer.Create(Self, nil,'',LViews).
    SetCache('Default',cacheRootIfNoSession,15).
    SetCache('ArticleView',cacheWithParametersIfNoSession,60);  

6. at program MVCServer:
   mORMoti18n.SetCurrentLanguage('GR');
