unit pUCGeral;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Buttons,
  Classes,
  ComCtrls,
  Controls,
  DB,
  DBGrids,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Grids,
  Messages,
  StdCtrls,
  SysUtils,
  UcBase,
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  Variants;

type

  { TFormUserPerf }

  TFormUserPerf = class(TForm)
    Panel1: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    SpeedUser: TSpeedButton;
    SpeedPerfil: TSpeedButton;
    Panel3: TPanel;
    SpeedLog: TSpeedButton;
    SpeedUserLog: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedUserClick(Sender: TObject);
    procedure SpeedPerfilClick(Sender: TObject);
    procedure SpeedLogClick(Sender: TObject);
    procedure SpeedUserLogClick(Sender: TObject);
    procedure SpeedUserMouseEnter(Sender: TObject);
    procedure SpeedUserMouseLeave(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  protected
    FrmFrame: TCustomFrame;
  private
    { Private declarations }
  public
    FUsercontrol: TUserControl;

    procedure LoadDatasets;
  end;

var
  FormUserPerf: TFormUserPerf;

implementation

uses
  pUCFrame_Log,
  pUCFrame_Profile,
  pUCFrame_User,
  pUcFrame_UserLogged,
  UCMessages;

{$R *.dfm}
{ --------------------------------------------------------------------------- }
{ FORM }

procedure TFormUserPerf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);
  Action := caFree;
end;

procedure TFormUserPerf.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TFormUserPerf.LoadDatasets;
begin
  with FUsercontrol do
  begin
    FUsercontrol.CurrentUser.PerfilUsuario := Nil;
    FUsercontrol.CurrentUser.PerfilUsuario := DataConnector.UCGetSQLDataset
      (Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Email, %s as Perfil, %s as Privilegiado, %s as Tipo, %s as Senha, %s as UserNaoExpira, %s as DaysOfExpire , %s as UserInative from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName,
      TableUsers.FieldEmail, TableUsers.FieldProfile,
      TableUsers.FieldPrivileged, TableUsers.FieldTypeRec,
      TableUsers.FieldPassword, TableUsers.FieldUserExpired,
      TableUsers.FieldUserDaysSun, TableUsers.FieldUserInative,
      TableUsers.TableName, TableUsers.FieldTypeRec, QuotedStr('U'),
      TableUsers.FieldLogin]));

    FUsercontrol.CurrentUser.PerfilGrupo := Nil;
    FUsercontrol.CurrentUser.PerfilGrupo := DataConnector.UCGetSQLDataset
      (Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Tipo from %s Where %s  = %s ORDER BY %s',
      [TableUsers.FieldUserID, TableUsers.FieldLogin, TableUsers.FieldUserName,
      TableUsers.FieldTypeRec, TableUsers.TableName, TableUsers.FieldTypeRec,
      QuotedStr('P'), TableUsers.FieldUserName]));
  end;
end;

procedure TFormUserPerf.FormShow(Sender: TObject);
begin
  LoadDatasets;

  SpeedPerfil.Visible := FUsercontrol.UserProfile.Active;
  SpeedLog.Visible := FUsercontrol.LogControl.Active;
  SpeedUserLog.Visible := FUsercontrol.UsersLogged.Active;

  SpeedUserClick(Sender);
  Caption := FUsercontrol.UserSettings.UsersForm.WindowCaption;

  SpeedUser.Caption := FUsercontrol.UserSettings.Log.ColUser;
  SpeedPerfil.Caption := FUsercontrol.UserSettings.UsersProfile.ColProfile;
  SpeedUserLog.Caption := FUsercontrol.UserSettings.UsersLogged.LabelDescricao;

end;

procedure TFormUserPerf.SpeedPerfilClick(Sender: TObject);
begin
  if FrmFrame is TFrame_Profile then
    Exit;
  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  LoadDatasets;

  FrmFrame := TFrame_Profile.Create(Self);
  TFrame_Profile(FrmFrame).DataPerfil.DataSet :=
    FUsercontrol.CurrentUser.PerfilGrupo;
  TFrame_Profile(FrmFrame).BtnClose.ModalResult := mrOk;
  TFrame_Profile(FrmFrame).Height := Panel3.Height;
  TFrame_Profile(FrmFrame).Width := Panel3.Width;
  TFrame_Profile(FrmFrame).FDataSetPerfilUsuario :=
    FUsercontrol.CurrentUser.PerfilGrupo;
  TFrame_Profile(FrmFrame).FUsercontrol := FUsercontrol;
  TFrame_Profile(FrmFrame).DbGridPerf.Columns[0].Title.Caption :=
    FUsercontrol.UserSettings.UsersProfile.ColProfile;
  with FUsercontrol.UserSettings.UsersProfile, TFrame_Profile(FrmFrame) do
  begin
    LbDescricao.Caption := LabelDescription;
    BtnAddPer.Caption := BtAdd;
    BtnAltPer.Caption := BtChange;
    BtnExcPer.Caption := BtDelete;
    BtnAcePer.Caption := BtRights;
    BtnClose.Caption := BtClose;
  end;
  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_User then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  LoadDatasets;

  FrmFrame := TUCFrame_User.Create(Self);
  TUCFrame_User(FrmFrame).FDataSetCadastroUsuario :=
    FUsercontrol.CurrentUser.PerfilUsuario;
  TUCFrame_User(FrmFrame).DataUser.DataSet := TUCFrame_User(FrmFrame)
    .FDataSetCadastroUsuario;
  TUCFrame_User(FrmFrame).DataPerfil.DataSet :=
    FUsercontrol.CurrentUser.PerfilGrupo;
  TUCFrame_User(FrmFrame).BtnClose.ModalResult := mrOk;
  TUCFrame_User(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_User(FrmFrame).Height := Panel3.Height;
  TUCFrame_User(FrmFrame).Width := Panel3.Width;
  TUCFrame_User(FrmFrame).SetWindow;
  LbDescricao.Caption := FUsercontrol.UserSettings.UsersForm.LabelDescription;

  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserLogClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_UsersLogged then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  FrmFrame := TUCFrame_UsersLogged.Create(Self);
  LbDescricao.Caption := FUsercontrol.UserSettings.UsersLogged.LabelDescricao;
  TUCFrame_UsersLogged(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_UsersLogged(FrmFrame).SetWindow;
  TUCFrame_UsersLogged(FrmFrame).Height := Panel3.Height;
  TUCFrame_UsersLogged(FrmFrame).Width := Panel3.Width;
  TUCFrame_UsersLogged(FrmFrame).BtExit.ModalResult := mrOk;
  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserMouseEnter(Sender: TObject);
begin
  with TSpeedButton(Sender) do
  begin
    Font.Style := [fsUnderline];
    Cursor := crHandPoint;
  end;
end;

procedure TFormUserPerf.SpeedUserMouseLeave(Sender: TObject);
begin
  with TSpeedButton(Sender) do
  begin
    Font.Style := [];
    Cursor := crDefault;
  end;
end;

procedure TFormUserPerf.SpeedLogClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_Log then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  FrmFrame := TUCFrame_Log.Create(Self);
  LbDescricao.Caption := FUsercontrol.UserSettings.Log.LabelDescription;
  TUCFrame_Log(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_Log(FrmFrame).SetWindow;
  TUCFrame_Log(FrmFrame).Height := Panel3.Height;
  TUCFrame_Log(FrmFrame).Width := Panel3.Width;
  TUCFrame_Log(FrmFrame).btfecha.ModalResult := mrOk;
  FrmFrame.Parent := Panel3;
end;

end.
