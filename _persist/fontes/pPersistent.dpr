program pPersistent;

uses
  Forms,
  uclsPersistent in 'uclsPersistent.pas',
  ufrmPersistent in 'ufrmPersistent.pas' {F_Persistent};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'pPersistent';
  Application.CreateForm(TF_Persistent, F_Persistent);
  Application.Run;
end.
