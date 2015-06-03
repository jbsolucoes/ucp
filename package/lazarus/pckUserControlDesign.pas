{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit pckUserControlDesign;

interface

uses
 UCEditorForm_U, UCIdle, UCObjSel_U, UCReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('UCReg', @UCReg.Register);
end;

initialization
  RegisterPackage('pckUserControlDesign', @Register);
end.
