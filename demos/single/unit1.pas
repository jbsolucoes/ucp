unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil, UCBase, UCSettings,
  ucsqldbconn, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    IBConnection1: TIBConnection;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    SQLTransaction1: TSQLTransaction;
    UCSettings1: TUCSettings;
    UCSQLdbConn1: TUCSQLdbConn;
    UserControl1: TUserControl;
    procedure FormCreate(Sender: TObject);
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
  UserControl1.Execute;
end;

end.

