program substituir;

uses
  Forms,
  usubstituir in 'usubstituir.pas' {F_Substituir};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Substituir, F_Substituir);
  Application.Run;
end.
