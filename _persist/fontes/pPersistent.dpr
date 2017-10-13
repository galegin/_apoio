program pPersistent;

uses
  Forms,
  uclsPersistentAbstract in 'uclsPersistentAbstract.pas',
  uclsPersistentCSharp in 'uclsPersistentCSharp.pas',
  uclsPersistentDelphi in 'uclsPersistentDelphi.pas',
  uclsPersistentDelphiXE in 'uclsPersistentDelphiXE.pas',
  uclsPersistentJava in 'uclsPersistentJava.pas',
  uclsPersistentPhp in 'uclsPersistentPhp.pas',
  ufrmPersistent in 'ufrmPersistent.pas' {F_Persistent};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'pPersistent';
  Application.CreateForm(TF_Persistent, F_Persistent);
  Application.Run;
end.
