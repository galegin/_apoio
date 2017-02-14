unit ufrmPersistent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Persistent = class(TForm)
    BtnTestar: TButton;
    BtnGerar: TButton;
    procedure BtnTestarClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
  private
  public
  end;

var
  F_Persistent: TF_Persistent;

implementation

{$R *.dfm}

uses
  uTraTransacao, uclsPersistent, mFilter;

procedure TF_Persistent.BtnTestarClick(Sender: TObject);
var
  vLstFilter : TmFilterList;
begin
  (* with TTra_Transacao.Create do begin
    Cd_Empresa := 1;
    Nr_Transacao := 1;
    Dt_Transacao := StrToDate('14/10/2011');

    Consultar(nil);
  end;

  with TTra_Transacao.Create do begin
    Cd_Empresa := 1;

    Listar(nil);
  end;

  with TTra_Transacao.Create do begin
    Cd_Empresa := 1;
    Nr_Transacao := 1;
    Dt_Transacao := Date;

    Excluir();

    Incluir();
    Alterar();

    Salvar();
  end; *)

  vLstFilter := TmFilterList.Create;
  with vLstFilter do begin
    Add(TmFilter.CreateS('Cd_Empresa', tpfLista, '1,2,3'));
    Add(TmFilter.CreateD('Dt_Transacao', StrToDate('01/01/2016'), StrToDate('31/12/2016')));
    Add(TmFilter.CreateF('Nr_Transacao', 1, 999999));
    Add(TmFilter.CreateS('Nr_Transacao', '1', '999999'));
    Add(TmFilter.CreateF('Nr_Transacao', tpfDiferente, 1));
    Add(TmFilter.CreateF('Nr_Transacao', tpfIgual, 2));
    Add(TmFilter.CreateF('Nr_Transacao', tpfMaior, 3));
    Add(TmFilter.CreateF('Nr_Transacao', tpfMaiorIgual, 4));
    Add(TmFilter.CreateF('Nr_Transacao', tpfMenor, 5));
    Add(TmFilter.CreateF('Nr_Transacao', tpfMenorIgual, 6));
    Add(TmFilter.Create('Nr_Transacao', tpfNaoNulo));
    Add(TmFilter.Create('Nr_Transacao', tpfNulo));
  end;
    
  with TTra_Transacao.Create(nil) do begin
    Listar(vLstFilter);
  end;
end;

procedure TF_Persistent.BtnGerarClick(Sender: TObject);
begin
  TC_Persistent.gerar();

  ShowMessage('Geracao efetuada com sucesso!');
end;

end.
