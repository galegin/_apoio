program pLibrary;

uses
  Forms,
  ufrmLibrary in 'ufrmLibrary.pas' {FrmLibrary};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLibrary, FrmLibrary);
  Application.Run;
end.
