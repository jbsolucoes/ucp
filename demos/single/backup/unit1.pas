unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, sqlite3conn, FileUtil, UCBase,
  UCSettings, ucsqldbconn, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    SQLite3Connection1: TSQLite3Connection;
    SQLTransaction1: TSQLTransaction;
    UCSettings1: TUCSettings;
    UCSQLdbConn1: TUCSQLdbConn;
    UserControl1: TUserControl;
    procedure FormCreate(Sender: TObject);
    procedure IBConnection1AfterConnect(Sender: TObject);
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

procedure TForm1.IBConnection1AfterConnect(Sender: TObject);
begin

end;

end.

