unit pUCFrame_Profile;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  Controls,
  Db,
  DBGrids,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Grids,
  IncPerfil_U,
  Messages,
  StdCtrls,
  SysUtils,
  UcBase,
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  UserPermis_U;

type
  TFrame_Profile = class(TFrame)
    DbGridPerf: TDBGrid;
    Panel2: TPanel;
    BtnAddPer: TBitBtn;
    BtnAltPer: TBitBtn;
    BtnExcPer: TBitBtn;
    BtnClose: TBitBtn;
    BtnAcePer: TBitBtn;
    DataPerfil: TDataSource;
    procedure BtnAddPerClick(Sender: TObject);
    procedure BtnAltPerClick(Sender: TObject);
    procedure BtnExcPerClick(Sender: TObject);
    procedure BtnAcePerClick(Sender: TObject);
  protected
    FIncluirPerfil: TfrmIncluirPerfil;
    procedure ActionBtPermissProfileDefault;
    procedure SetWindowPerfil(Adicionar: Boolean);
    procedure SetWindowProfile;
  private
    { Private declarations }
  public
    fUserControl: TUserControl;
    FDataSetPerfilUsuario: TDataset;
    destructor Destroy; override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame_Profile.SetWindowPerfil(Adicionar: Boolean);
begin
  with fUserControl.UserSettings.AddChangeProfile do
  begin
    FIncluirPerfil.Caption := WindowCaption;
    if Adicionar then
      FIncluirPerfil.LbDescricao.Caption := LabelAdd
    else
      FIncluirPerfil.LbDescricao.Caption := LabelChange;

    FIncluirPerfil.lbNome.Caption := LabelName;
    FIncluirPerfil.btGravar.Caption := BtSave;
    FIncluirPerfil.btCancela.Caption := BtCancel;
    FIncluirPerfil.Position := fUserControl.UserSettings.WindowsPosition;
    FIncluirPerfil.FDataSetPerfilUsuario := FDataSetPerfilUsuario;
  end;
end;

procedure TFrame_Profile.ActionBtPermissProfileDefault;
var
  TempCampos, TempCamposEX: String;
begin
  UserPermis.FTempIdUser := FDataSetPerfilUsuario.FieldByName('IdUser')
    .AsInteger;
  with fUserControl do
  begin
    TempCampos :=
      Format(' %s as IdUser, %s as Modulo, %s as ObjName, %s as UCKey ',
      [TableRights.FieldUserID, TableRights.FieldModule,
      TableRights.FieldComponentName, TableRights.FieldKey]);
    TempCamposEX := Format('%s, %s as FormName ',
      [TempCampos, TableRights.FieldFormName]);

    UserPermis.DSPermiss := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab Where tab.%s = %s and tab.%s = %s',
      [TempCampos, TableRights.TableName, TableRights.FieldUserID,
      FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));

    UserPermis.DSPermiss.Open;

    UserPermis.DSPermissEX := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab1 Where tab1.%s = %s and tab1.%s = %s',
      [TempCamposEX, TableRights.TableName + 'EX', TableRights.FieldUserID,
      FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));

    UserPermis.DSPermissEX.Open;

    UserPermis.DSPerfil := TDataset.Create(UserPermis);

    UserPermis.ShowModal;

    FDataSetPerfilUsuario.Close;
    FDataSetPerfilUsuario.Open;
    FDataSetPerfilUsuario.Locate('idUser', UserPermis.FTempIdUser, []);

    FreeAndNil(UserPermis);
  end;
end;

procedure TFrame_Profile.SetWindowProfile;
begin
  with fUserControl.UserSettings.Rights do
  begin
    UserPermis.Caption := WindowCaption;
    UserPermis.LbDescricao.Caption := LabelProfile;
    UserPermis.lbUser.Left := UserPermis.LbDescricao.Left +
      UserPermis.LbDescricao.Width + 5;
    UserPermis.PageMenu.Caption := PageMenu;
    UserPermis.PageAction.Caption := PageActions;
    UserPermis.PageControls.Caption := PageControls; // By Vicente Barros Leonel
    UserPermis.BtLibera.Caption := BtUnlock;
    UserPermis.BtBloqueia.Caption := BtLock;
    UserPermis.BtGrava.Caption := BtSave;
    UserPermis.BtCancel.Caption := BtCancel;
    UserPermis.Position := fUserControl.UserSettings.WindowsPosition;
  end;
end;

procedure TFrame_Profile.BtnAcePerClick(Sender: TObject);
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  UserPermis := TUserPermis.Create(self);
  UserPermis.fUserControl := fUserControl;
  SetWindowProfile;
  UserPermis.lbUser.Caption := FDataSetPerfilUsuario.FieldByName
    ('Nome').AsString;
  ActionBtPermissProfileDefault;
end;

procedure TFrame_Profile.BtnAddPerClick(Sender: TObject);
begin
  try
    FIncluirPerfil := TfrmIncluirPerfil.Create(self);
    FIncluirPerfil.fUserControl := self.fUserControl;
    SetWindowPerfil(True);
    FIncluirPerfil.ShowModal;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TFrame_Profile.BtnAltPerClick(Sender: TObject);
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  try
    FIncluirPerfil := TfrmIncluirPerfil.Create(self);
    FIncluirPerfil.fUserControl := self.fUserControl;
    FIncluirPerfil.FNewIdUser := FDataSetPerfilUsuario.FieldByName('IdUser')
      .AsInteger;
    SetWindowPerfil(False);
    with FIncluirPerfil do
    begin
      EditDescricao.Text := FDataSetPerfilUsuario.FieldByName('Nome').AsString;
      FAltera := True;
      ShowModal;
    end;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TFrame_Profile.BtnExcPerClick(Sender: TObject);
var
  TempID: Integer;
  CanDelete: Boolean;
  ErrorMsg: String;
  TempDS: TDataset;
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  TempID := FDataSetPerfilUsuario.FieldByName('IDUser').AsInteger;
  TempDS := fUserControl.DataConnector.UCGetSQLDataset
    ('Select ' + fUserControl.TableUsers.FieldUserID + ' as IdUser from ' +
    fUserControl.TableUsers.TableName + ' Where ' +
    fUserControl.TableUsers.FieldTypeRec + ' = ' + QuotedStr('U') + ' AND ' +
    fUserControl.TableUsers.FieldProfile + ' = ' + IntToStr(TempID));

  if TempDS.FieldByName('IdUser').AsInteger > 0 then
  begin
    TempDS.Close;
    FreeAndNil(TempDS);
    // changed by fduenas: PromptDelete_WindowCaption
    if MessageBox(handle,
      PChar(Format(fUserControl.UserSettings.UsersProfile.PromptDelete,
      [FDataSetPerfilUsuario.FieldByName('Nome').AsString])),
      PChar(fUserControl.UserSettings.UsersProfile.PromptDelete_WindowCaption),
      MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) <> idYes then
      Exit;
  end
  else
  begin
    TempDS.Close;
    FreeAndNil(TempDS);
  end;

  CanDelete := True;
  if Assigned(fUserControl.onDeleteProfile) then
    fUserControl.onDeleteProfile(TObject(Owner), TempID, CanDelete, ErrorMsg);
  if not CanDelete then
  begin
    MessageDlg(ErrorMsg, mtWarning, [mbOK], 0);
    Exit;
  end;

  with fUserControl do
  begin
    DataConnector.UCExecSQL('Delete from ' + TableUsers.TableName + ' where ' +
      TableUsers.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + ' where ' +
      TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + 'EX where '
      + TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Update ' + TableUsers.TableName + ' Set ' +
      TableUsers.FieldProfile + ' = null where ' + TableUsers.FieldUserID +
      ' = ' + IntToStr(TempID));
  end;
  FDataSetPerfilUsuario.Close;
  FDataSetPerfilUsuario.Open;
end;

destructor TFrame_Profile.Destroy;
begin
  // nada a destruir
  // não destruir o FDataSetPerfilUsuario o USERCONTROL toma conta dele
  inherited;
end;

end.
