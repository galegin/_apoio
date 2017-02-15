program pConverter;

uses
  Forms,
  uclsTipoConv in 'uclsTipoConv.pas',
  uclsTipoLing in 'uclsTipoLing.pas',
  uintLing in 'uintLing.pas',
  uclsLing in 'uclsLing.pas',
  uclsLingCSharp in 'uclsLingCSharp.pas',
  uclsLingDelphi in 'uclsLingDelphi.pas',
  uclsLingJava in 'uclsLingJava.pas',
  uclsLingUniface in 'uclsLingUniface.pas',
  uclsConverter in 'uclsConverter.pas',
  ufrmConveter in 'ufrmConveter.pas' {FrmConverter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmConverter, FrmConverter);
  Application.Run;
end.
