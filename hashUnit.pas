unit hashUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  SynCommons;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var result: string;
h: cardinal;

begin

  h:= Hash32(
    // resourcestring are expected to be in English, that is WinAnsi encoded
    {$ifdef UNICODE}StringToWinAnsi{$endif}(Edit1.Text));
 memo1.Lines.Add( inttostr(h)+'='+Edit1.Text);
end;


end.
