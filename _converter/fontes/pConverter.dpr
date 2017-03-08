program pConverter;

uses
  Forms,
  uclsTipoParte in 'uclsTipoParte.pas',
  uclsConverter in 'uclsConverter.pas',
  ufrmConveter in 'ufrmConveter.pas' {FrmConverter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmConverter, FrmConverter);
  Application.Run;
end.
