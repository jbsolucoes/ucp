unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil, Forms, Controls,
  Graphics, Dialogs, Menus, ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    actCadastroClientes: TAction;
    actCadastroProdutos: TAction;
    actControleUsuarios: TAction;
    actAlterarSenha: TAction;
    actControleAcesso: TAction;
    actLogout: TAction;
    ActionList1: TActionList;
    IBConnection1: TIBConnection;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    SQLTransaction1: TSQLTransaction;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

