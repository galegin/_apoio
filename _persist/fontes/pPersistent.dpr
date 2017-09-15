program pPersistent;

uses
  Forms,
  uclsPersistentCollection in 'uclsPersistentCollection.pas',
  uclsPersistentContexto in 'uclsPersistentContexto.pas',
  ufrmPersistent in 'ufrmPersistent.pas' {F_Persistent},
  uclsPersistentAbstract in 'uclsPersistentAbstract.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'pPersistent';
  Application.CreateForm(TF_Persistent, F_Persistent);
  Application.Run;
end.
