{-----------------------------------------------------------------------------
 Unit Name: UCSQLdbConn
 Author:    QmD
 Date:      08-nov-2004
 Purpose:   SQLdb Support

 registered in UCSQLdbReg.pas
-----------------------------------------------------------------------------}

unit ucsqldbconn;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

//{$I 'UserControl.inc'}

uses
  Classes,
  DB,
  SysUtils,
  LResources,
  UCDataConnector,
  sqldb;

type
  TUCSQLdbConn = class(TUCDataConnector)
  private
    FConnection: TSQLConnection;
    procedure SetFConnection(const Value: TSQLConnection);
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
    property Connection: TSQLConnection read FConnection write SetFConnection;
  end;

implementation

uses Dialogs;

{ TUCSQLdbConn }

procedure TUCSQLdbConn.SetFConnection(const Value: TSQLConnection);
begin
  if FConnection <> Value then
    FConnection := Value;
  if FConnection <> nil then
    FConnection.FreeNotification(Self);
end;

procedure TUCSQLdbConn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
  inherited Notification(AComponent, Operation);
end;

function TUCSQLdbConn.UCFindTable(const TableName: String): Boolean;
var
  TempList: TStringList;
begin
  if not assigned(FConnection) then
    raise exception.create('Connection not assigned!');

  try
    TempList := TStringList.Create;
    FConnection.GetTableNames(TempList);
    TempList.Text := UpperCase(TempList.Text);
    Result        := TempList.IndexOf(UpperCase(TableName)) > -1;
  Except
    Result        := false;
  end;
  FreeAndNil(TempList);  
end;

function TUCSQLdbConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FConnection) and (FConnection.Connected);
end;

function TUCSQLdbConn.GetDBObjectName: String;
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

function TUCSQLdbConn.GetTransObjectName: String;
begin
  Result := '';
end;

procedure TUCSQLdbConn.UCExecSQL(FSQL: String);
begin
  if not assigned(FConnection) then
    exit;

  with TSQLQuery.Create(nil) do
  begin
    try
      Connection := FConnection;
      DataBase   := FConnection;
      SQL.Text   := FSQL;

      try ExecSQL;
      except on e:exception do
        begin
          FConnection.Transaction.Rollback;

          raise exception.create(format('ExecSQL error: %s',[e.message]));
        end;
      end;

      FConnection.Transaction.Commit;
    finally
      Free;
    end;
  end;
end;

function TUCSQLdbConn.UCGetSQLDataset(FSQL: String): TDataset;
begin
  Result := TSQLQuery.Create(nil);
  with Result as TSQLQuery do
  begin
    Connection := FConnection;
    DataBase   := FConnection;
    SQL.Text   := FSQL;
    Open;
  end;
end;

initialization
  {$I ucsqldbconn.lrs}

end.

