unit ucsqldbconnreg;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses Classes, LResources;

procedure Register;

implementation

uses UCSQLdbConn;

procedure Register;
begin
  RegisterComponents('UC Connectors', [TUCSQLdbConn]);
end;

initialization
  {$I ucsqldbconn.lrs}

end.
