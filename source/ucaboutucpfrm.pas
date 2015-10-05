unit ucaboutucpfrm;

interface

{$I 'UserControl.inc'}

uses
  Messages,
  Buttons,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  {$IFNDEF FPC}
  jpeg,
  {$ENDIF}
  StdCtrls;

type

  { TUCAboutForm }

  TUCAboutForm = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    lblVersao: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Panel3: TPanel;
    Label9: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MemoAgrd: TMemo;
    Label1: TLabel;
    Image3: TImage;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    pnlFundo: TPanel;
    pnlComponentes: TPanel;
    Image4: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label4Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure WMNChitTest(var M: TWMNchitTest); message WM_NCHITTEST;
    { Private declarations }
  public
    { Public declarations }
  end;

  var
    AboutFrmUCP: TUCAboutForm;

implementation

uses
  ShellAPI,
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  UCBase;

{$R ucaboutucpfrm.lfm}

procedure TUCAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TUCAboutForm.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TUCAboutForm.Label4Click(Sender: TObject);
begin
  // ShellExecute(0, 'open', 'mailto:qmd@usercontrol.com.br', '', '', SW_SHOW);
end;

procedure TUCAboutForm.Label6Click(Sender: TObject);
begin
  // ShellExecute(0, 'open', 'http://www.usercontrol.net', '', '', SW_SHOW);
end;

procedure TUCAboutForm.Image2Click(Sender: TObject);
begin
  // ShellExecute(0, 'open', 'http://delphiland.dyns.cx', nil, nil, SW_SHOW);
end;

procedure TUCAboutForm.Image3Click(Sender: TObject);
begin
  // ShellExecute(0, 'open', 'http://www.curitiba.pr.gov.br/', nil, nil, SW_SHOW);
end;

procedure TUCAboutForm.FormCreate(Sender: TObject);
begin
  Self.BorderStyle := bsNone;
  lblVersao.Caption := 'Versão ' + UCVersion;
end;

procedure TUCAboutForm.FormShow(Sender: TObject);
begin
  // pnlComponentes.Top  := Round((pnlFundo.Height - pnlComponentes.Height) / 2);
  // pnlComponentes.Left := Round((pnlFundo.Width - pnlComponentes.Width) / 2);
end;

procedure TUCAboutForm.WMNChitTest(var M: TWMNchitTest);
begin
  inherited;
  if M.result = htclient then
    M.result := htCaption;
end;

end.
