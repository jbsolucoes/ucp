{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit pckZeosConn;

interface

uses
 UCZEOSConn, UCZEOSConnReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('UCZEOSConnReg', @UCZEOSConnReg.Register);
end;

initialization
  RegisterPackage('pckZeosConn', @Register);
end.
