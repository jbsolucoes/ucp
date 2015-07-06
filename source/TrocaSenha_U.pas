unit TrocaSenha_U;

interface

{$I 'UserControl.inc'}

uses
{$IFDEF DELPHI5_UP}
  Variants,
{$ENDIF}
  Buttons,
  Classes,
  Controls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  // UCConsts,
  UCBase; { Por Vicente Barros Leonel }

type
  TTrocaSenha = class(TForm)
    Panel1: TPanel;
    lbDescricao: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    btGrava: TBitBtn;
    btCancel: TBitBtn;
    Panel2: TPanel;
    lbSenhaAtu: TLabel;
    lbNovaSenha: TLabel;
    lbConfirma: TLabel;
    EditAtu: TEdit;
    EditNova: TEdit;
    EditConfirma: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    fUsercontrol: TUserControl; { Por Vicente Barros Leonel }
    ForcarTroca: Boolean;
    { Public declarations }
  end;

  {
    var
    TrocaSenha: TTrocaSenha;
  }

implementation

{$R *.dfm}

procedure TTrocaSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTrocaSenha.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TTrocaSenha.FormActivate(Sender: TObject);
begin
  EditAtu.CharCase := Self.fUsercontrol.Login.CharCasePass;
  EditNova.CharCase := Self.fUsercontrol.Login.CharCasePass;
  EditConfirma.CharCase := Self.fUsercontrol.Login.CharCasePass;
  { Por Vicente Barros Leonel }
end;

procedure TTrocaSenha.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  If ForcarTroca = True then
  Begin
    CanClose := False;
    MessageDlg(fUsercontrol.UserSettings.CommonMessages.ForcaTrocaSenha,
      mtWarning, [mbOK], 0);
  End;
end;

end.
