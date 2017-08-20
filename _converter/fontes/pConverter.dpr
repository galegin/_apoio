program pConverter;

uses
  Forms,
  ufrmConverter in 'ufrmConverter.pas' {F_Converter},
  uclsConverterDelphiToCSharp in 'uclsConverterDelphiToCSharp.pas',
  uclsConverterUnifaceToCSharp in 'uclsConverterUnifaceToCSharp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'pConverter';
  Application.CreateForm(TF_Converter, F_Converter);
  Application.Run;
end.
