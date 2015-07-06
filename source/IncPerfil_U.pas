unit IncPerfil_U;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  Controls,
  DB,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  UCBase;

type
  TfrmIncluirPerfil = class(TForm)
    Panel1: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    btGravar: TBitBtn;
    btCancela: TBitBtn;
    Panel2: TPanel;
    lbNome: TLabel;
    EditDescricao: TEdit;
    procedure btCancelaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
  private
    function GetNewIdUser: Integer;
    { Private declarations }
  public
    FAltera: Boolean;
    FUserControl: TUserControl;
    FNewIdUser: Integer;
    FDataSetPerfilUsuario: TDataSet;
  end;

implementation

{$R *.dfm}

procedure TfrmIncluirPerfil.btCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIncluirPerfil.btGravarClick(Sender: TObject);
var
  FProfile: String;
begin
  btGravar.Enabled := False;
  with FUserControl do
    if not FAltera then
    begin // inclui perfil
      FNewIdUser := GetNewIdUser;
      FProfile := EditDescricao.Text;
      if Assigned(onAddProfile) then
        onAddProfile(TObject(Self.Owner.Owner), FProfile);

      DataConnector.UCExecSQL
        (Format('INSERT INTO %s(%s, %s, %s) Values(%d,%s,%s)',
        [TableUsers.TableName, TableUsers.FieldUserID, TableUsers.FieldUserName,
        TableUsers.FieldTypeRec, FNewIdUser, QuotedStr(FProfile),
        QuotedStr('P')]));

    end
    else
    begin // alterar perfil
      // FNewIdUser := TfrmCadastrarPerfil(Self.Owner).FDataSetPerfilUsuario.FieldByName('IdUser').AsInteger;
      FProfile := EditDescricao.Text;

      DataConnector.UCExecSQL(Format('UPDATE %s SET %s = %s WHERE %s = %d',
        [TableUsers.TableName, TableUsers.FieldUserName, QuotedStr(FProfile),
        TableUsers.FieldUserID, FNewIdUser]));
    end;
  FDataSetPerfilUsuario.Close;
  FDataSetPerfilUsuario.Open;
  FDataSetPerfilUsuario.Locate('IDUser', FNewIdUser, []);
  Close;
end;

function TfrmIncluirPerfil.GetNewIdUser: Integer;
var
  TempDs: TDataSet;
begin
  with FUserControl do
    TempDs := DataConnector.UCGetSQLDataSet('SELECT ' + TableUsers.FieldUserID +
      ' as MaxUserID from ' + TableUsers.TableName + ' ORDER BY ' +
      TableUsers.FieldUserID + ' DESC');
  Result := TempDs.FieldByName('MaxUserID').AsInteger + 1;
  TempDs.Close;
  FreeAndNil(TempDs);
end;

end.
