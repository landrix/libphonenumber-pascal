program DUnitXGuiRunner;

{$APPTYPE GUI}

{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  Vcl.Forms,
  DUnitX.TestFramework,
  DUnitX.Loggers.GUI.VCL,
  LibPhoneNumber.PhoneNumberUtil.Tests in 'LibPhoneNumber.PhoneNumberUtil.Tests.pas',
  LibPhoneNumber.PhoneNumberUtil in '..\src\LibPhoneNumber.PhoneNumberUtil.pas',
  LibPhoneNumber.Types in '..\src\LibPhoneNumber.Types.pas'
  ;

begin
  // GUI runner for the DUnitX tests
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGUIVCLTestRunner, GUIVCLTestRunner);
  Application.Run;
end.
