program pPersistent;

uses
  Forms,
  uclsPersistentAbstract in 'uclsPersistentAbstract.pas',
  uclsPersistentAttribute in 'uclsPersistentAttribute.pas',
  uclsPersistentCollection in 'uclsPersistentCollection.pas',
  ufrmPersistent in 'ufrmPersistent.pas' {F_Persistent};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'pPersistent';
  Application.CreateForm(TF_Persistent, F_Persistent);
  Application.Run;
end.
