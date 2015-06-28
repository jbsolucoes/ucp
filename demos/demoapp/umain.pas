unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IBConnection, sqldb, FileUtil, UCBase, ucsqldbconn, Forms,
  Controls, Graphics, Dialogs, Menus, ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    actCadastroClientes: TAction;
    actCadastroProdutos: TAction;
    actControleUsuarios: TAction;
    actAlterarSenha: TAction;
    actLogout: TAction;
    ActionList1: TActionList;
    IBConnection1: TIBConnection;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    SQLTransaction1: TSQLTransaction;
    UCSQLdbConn1: TUCSQLdbConn;
    UserControl1: TUserControl;
    procedure actCadastroClientesExecute(Sender: TObject);
    procedure actCadastroProdutosExecute(Sender: TObject);
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
  IBConnection1.Connected := true;
end;

procedure TForm1.actCadastroClientesExecute(Sender: TObject);
begin
  showmessage('Clientes');
end;

procedure TForm1.actCadastroProdutosExecute(Sender: TObject);
begin
  showmessage('Produtos');
end;

end.

