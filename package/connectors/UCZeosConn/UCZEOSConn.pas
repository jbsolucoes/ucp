{-----------------------------------------------------------------------------
 Unit Name: UCZEOSConn
 Author:    QmD
 Date:      08-nov-2004
 Purpose:   ZEOS 6 Support

 registered in UCZEOSReg.pas
-----------------------------------------------------------------------------}

unit UCZEOSConn;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

//{$I 'UserControl.inc'}

uses
  Classes,
  DB,
  SysUtils,
  UCDataConnector,
  ZConnection;

type
  TUCZEOSConn = class(TUCDataConnector)
  private
    FConnection: TZConnection;
    procedure SetFConnection(const Value: TZConnection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function GetDBObjectName: String; override;
    function GetTransObjectName: String; override;
    function UCFindDataConnection: Boolean; override;
    function UCFindTable(const Tablename: String): Boolean; override;
    function UCGetSQLDataset(FSQL: String): TDataset; override;
    procedure UCExecSQL(FSQL: String); override;
  published
    property Connection: TZConnection read FConnection write SetFConnection;
  end;

{$IFnDEF FPC}
uses
  ZDataset;
{$ELSE}
{$ENDIF}

implementation

uses ZDataset, Dialogs;

{ TUCZEOSConn }

procedure TUCZEOSConn.SetFConnection(const Value: TZConnection);
begin
  if FConnection <> Value then
    FConnection := Value;
  if FConnection <> nil then
    FConnection.FreeNotification(Self);
end;

procedure TUCZEOSConn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
  inherited Notification(AComponent, Operation);
end;

function TUCZEOSConn.UCFindTable(const TableName: String): Boolean;
var
  TempList: TStringList;
begin
  try
    TempList := TStringList.Create;
    FConnection.GetTableNames('', TempList);
    TempList.Text := UpperCase(TempList.Text);
    Result        := TempList.IndexOf(UpperCase(TableName)) > -1;
  Except
    Result        := false;
  end;
  FreeAndNil(TempList);  
end;

function TUCZEOSConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FConnection) and (FConnection.Connected);
end;

function TUCZEOSConn.GetDBObjectName: String;
begin
  if Assigned(FConnection) then
  begin
    if Owner = FConnection.Owner then
      Result := FConnection.Name
    else
    begin
      Result := FConnection.Owner.Name + '.' + FConnection.Name;
    end;
  end
  else
    Result := '';
end;

function TUCZEOSConn.GetTransObjectName: String;
begin
  Result := '';
end;

procedure TUCZEOSConn.UCExecSQL(FSQL: String);
begin
  with TZQuery.Create(nil) do
  begin
    Connection := FConnection;
    SQL.Text   := FSQL;
    try ExecSQL; except end;
    If FConnection.AutoCommit = False then
      FConnection.Commit;
    Free;
  end;
end;

function TUCZEOSConn.UCGetSQLDataset(FSQL: String): TDataset;
begin
  Result := TZQuery.Create(nil);
  with Result as TZQuery do
  begin
    Connection := FConnection;
    SQL.Text   := FSQL;
    Open;
  end;
end;

end.

