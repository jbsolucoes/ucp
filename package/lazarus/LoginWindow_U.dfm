object frmLoginWindow: TfrmLoginWindow
  Left = 343
  Height = 171
  Top = 286
  Width = 350
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 171
  ClientWidth = 350
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  KeyPreview = True
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  Position = poMainFormCenter
  LCLVersion = '1.4.0.4'
  object PTop: TPanel
    Left = 0
    Height = 17
    Top = 0
    Width = 350
    Align = alTop
    BevelOuter = bvNone
    ClientHeight = 17
    ClientWidth = 350
    TabOrder = 0
    object ImgTop: TImage
      Left = 0
      Height = 0
      Top = 0
      Width = 0
      AutoSize = True
      Center = True
    end
  end
  object PLeft: TPanel
    Left = 0
    Height = 120
    Top = 17
    Width = 10
    Align = alLeft
    BevelOuter = bvNone
    ClientHeight = 120
    ClientWidth = 10
    TabOrder = 1
    object imgLeft: TImage
      Left = 0
      Height = 0
      Top = 0
      Width = 0
      AutoSize = True
      Center = True
      Transparent = True
    end
  end
  object PBottom: TPanel
    Left = 0
    Height = 11
    Top = 137
    Width = 350
    Align = alBottom
    BevelOuter = bvNone
    ClientHeight = 11
    ClientWidth = 350
    TabOrder = 2
    object ImgBottom: TImage
      Left = 0
      Height = 0
      Top = 0
      Width = 0
      AutoSize = True
      Center = True
    end
  end
  object Panel1: TPanel
    Left = 10
    Height = 120
    Top = 17
    Width = 340
    Align = alClient
    BevelOuter = bvNone
    ClientHeight = 120
    ClientWidth = 340
    TabOrder = 3
    object PLogin: TPanel
      Left = 6
      Height = 132
      Top = -1
      Width = 340
      BevelOuter = bvNone
      ClientHeight = 132
      ClientWidth = 340
      TabOrder = 0
      object LbUsuario: TLabel
        Left = 33
        Height = 13
        Top = 10
        Width = 42
        Alignment = taRightJustify
        Caption = 'Usuário :'
        ParentColor = False
      end
      object LbSenha: TLabel
        Left = 38
        Height = 13
        Top = 42
        Width = 37
        Alignment = taRightJustify
        Caption = 'Senha :'
        ParentColor = False
      end
      object lbEsqueci: TLabel
        Cursor = crHandPoint
        Left = 87
        Height = 13
        Top = 70
        Width = 79
        Caption = 'Esqueci a senha'
        Enabled = False
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object EditUsuario: TEdit
        Left = 82
        Height = 21
        Top = 7
        Width = 225
        CharCase = ecUppercase
        MaxLength = 15
        OnChange = EditUsuarioChange
        TabOrder = 0
      end
      object EditSenha: TEdit
        Left = 82
        Height = 21
        Top = 39
        Width = 225
        EchoMode = emPassword
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 1
      end
      object btOK: TBitBtn
        Left = 63
        Height = 25
        Top = 95
        Width = 100
        Caption = 'OK'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C8D0D400C8D0
          D400C8D0D400B6907D00B57F6800C6C9CC00C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C7CCD000C1806000C6503000B75A4100C3BFBD00C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400BFADA500D1886200C4724700C4502E00BA6F5C00C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C7CE
          D200C0866900D1875F00C5724900C5734A00BF432500C1B6B300C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C0AA
          9F00D6916C00CD774F00B94A2E00CC856000C7613C00B85F4700C7CFD300C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400BCA19500D08D
          6A00D58D6500C84C2D00BD9E9300BD968200D2896400C5462800BF968C00C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C1B5B100C585
          6400D37B5900B96B5400C7CCD000C6CBCE00BE836500D2886200C4472D00C6B8
          B800C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C5C7
          C800BFB0AA00C6CBCD00C8D0D400C8D0D400C2BDBB00C8846100D07C5600C158
          4500C6CBCE00C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400BEADA500CE876100CD6B
          4900C5776B00C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400BDA49700D18D
          6800CD684600C6878000C7CFD300C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400BEA3
          9500D6937000CA603E00C7908A00C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C0A79C00CD876100C95D3D00C89B9700C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400BFADA500C6815D00CC5D4100C79F9B00C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C2BCBB00C1876A00CB614400BEA59C00C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C6CACD00BB9A8A00B99A8B00C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
          D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400
        }
        TabOrder = 2
      end
      object BtCancela: TBitBtn
        Left = 176
        Height = 25
        Top = 95
        Width = 100
        Cancel = True
        DefaultCaption = True
        Kind = bkCancel
        ModalResult = 2
        OnClick = BtCancelaClick
        TabOrder = 3
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Height = 23
    Top = 148
    Width = 350
    Panels = <    
      item
        Alignment = taRightJustify
        Text = 'Tentativa: '
        Width = 60
      end    
      item
        Alignment = taCenter
        Width = 80
      end    
      item
        Alignment = taRightJustify
        Text = 'Limite de Tentativas: '
        Width = 130
      end    
      item
        Alignment = taCenter
        Width = 50
      end>
  end
end
