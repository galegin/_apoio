program pPersistent;

uses
  Forms,
  //mModulo,
  //mControl,
  //mForm,
  //mFormControl,
  //mFrame,
  //mFrameControl,
  //mJson,
  //mRegXml,
  //mXml,
  //uGerOperacao in 'model\uGerOperacao.pas',
  //uPesPessoa in 'model\uPesPessoa.pas',
  //uPrdProduto in 'model\uPrdProduto.pas',
  //uTraTransacao in 'model\uTraTransacao.pas',
  //uTraTransItem in 'model\uTraTransItem.pas',
  //uTraItemImposto in 'model\uTraItemImposto.pas',
  uclsPersistent in 'uclsPersistent.pas',
  ufrmPersistent in 'ufrmPersistent.pas' {F_Persistent};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_Persistent, F_Persistent);
  Application.Run;
end.
