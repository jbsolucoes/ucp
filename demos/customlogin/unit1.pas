unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, sqlite3conn, FileUtil, UCBase,
  UCSettings, ucsqldbconn, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ulogin;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    SQLite3Connection1: TSQLite3Connection;
    SQLTransaction1: TSQLTransaction;
    UCControls1: TUCControls;
    UCSettings1: TUCSettings;
    UCSQLdbConn1: TUCSQLdbConn;
    UserControl1: TUserControl;
    procedure FormCreate(Sender: TObject);
    procedure UserControl1CustomLoginForm(Sender: TObject;
      var CustomForm: TCustomForm);
    procedure UserControl1LoginSucess(Sender: TObject; IdUser: Integer;
      Usuario, Nome, Senha, Email: String; Privileged: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  SQLite3Connection1.DatabaseName:='..\db\demo.db';
  SQLite3Connection1.Connected:=true;

  UserControl1.Execute;
end;

procedure TForm1.UserControl1CustomLoginForm(Sender: TObject;
  var CustomForm: TCustomForm);
begin
  application.createform(tfLogin, fLogin);

  CustomForm := fLogin;

end;

procedure TForm1.UserControl1LoginSucess(Sender: TObject; IdUser: Integer;
  Usuario, Nome, Senha, Email: String; Privileged: Boolean);
begin
  label1.caption := 'User '+ Usuario + ' logged!';
end;


end.

