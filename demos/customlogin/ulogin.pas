unit ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfLogin }

  TfLogin = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edUser: TEdit;
    edPass: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fLogin: TfLogin;

implementation

uses
  Unit1;

{$R *.lfm}

{ TfLogin }

procedure TfLogin.Button1Click(Sender: TObject);
begin
  if form1.UserControl1.VerificaLogin(edUser.text, edPass.text) = 0 then
    close
  else
    showmessage('Invalid login!');
end;

procedure TfLogin.Button2Click(Sender: TObject);
begin
  application.Terminate;
end;

end.

