unit uTraTransacadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacadic = class;
  TTra_TransacadicClass = class of TTra_Transacadic;

  TTra_TransacadicList = class;
  TTra_TransacadicListClass = class of TTra_TransacadicList;

  TTra_Transacadic = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Inclusao: TDateTime;
    fCd_Usuemail: Real;
    fDt_Ultemail: TDateTime;
    fDs_Paraultemail: String;
    fNr_Envioemail: Real;
    fNr_Prazomedio: Real;
    fNm_Checkout: String;
    fDt_Baseparcela: TDateTime;
    fCd_Tabpreco: Real;
    fCd_Ccusto: Real;
    fCd_Empagrup: Real;
    fCd_Agrupador: String;
    fCd_Despesa: Real;
    fCd_Pessoaprop: Real;
    fCd_Propriedade: Real;
    fTp_Bonusdesc: Real;
    fVl_Bonusdesc: Real;
    fVl_Basebonusdesc: Real;
    fCd_Familiar: Real;
    fPr_Simulador: Real;
    fVl_Simulador: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Inclusao : TDateTime read fDt_Inclusao write fDt_Inclusao;
    property Cd_Usuemail : Real read fCd_Usuemail write fCd_Usuemail;
    property Dt_Ultemail : TDateTime read fDt_Ultemail write fDt_Ultemail;
    property Ds_Paraultemail : String read fDs_Paraultemail write fDs_Paraultemail;
    property Nr_Envioemail : Real read fNr_Envioemail write fNr_Envioemail;
    property Nr_Prazomedio : Real read fNr_Prazomedio write fNr_Prazomedio;
    property Nm_Checkout : String read fNm_Checkout write fNm_Checkout;
    property Dt_Baseparcela : TDateTime read fDt_Baseparcela write fDt_Baseparcela;
    property Cd_Tabpreco : Real read fCd_Tabpreco write fCd_Tabpreco;
    property Cd_Ccusto : Real read fCd_Ccusto write fCd_Ccusto;
    property Cd_Empagrup : Real read fCd_Empagrup write fCd_Empagrup;
    property Cd_Agrupador : String read fCd_Agrupador write fCd_Agrupador;
    property Cd_Despesa : Real read fCd_Despesa write fCd_Despesa;
    property Cd_Pessoaprop : Real read fCd_Pessoaprop write fCd_Pessoaprop;
    property Cd_Propriedade : Real read fCd_Propriedade write fCd_Propriedade;
    property Tp_Bonusdesc : Real read fTp_Bonusdesc write fTp_Bonusdesc;
    property Vl_Bonusdesc : Real read fVl_Bonusdesc write fVl_Bonusdesc;
    property Vl_Basebonusdesc : Real read fVl_Basebonusdesc write fVl_Basebonusdesc;
    property Cd_Familiar : Real read fCd_Familiar write fCd_Familiar;
    property Pr_Simulador : Real read fPr_Simulador write fPr_Simulador;
    property Vl_Simulador : Real read fVl_Simulador write fVl_Simulador;
  end;

  TTra_TransacadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacadic;
    procedure SetItem(Index: Integer; Value: TTra_Transacadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacadic;
    property Items[Index: Integer]: TTra_Transacadic read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacadic }

constructor TTra_Transacadic.Create;
begin

end;

destructor TTra_Transacadic.Destroy;
begin

  inherited;
end;

{ TTra_TransacadicList }

constructor TTra_TransacadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacadic);
end;

function TTra_TransacadicList.Add: TTra_Transacadic;
begin
  Result := TTra_Transacadic(inherited Add);
  Result.create;
end;

function TTra_TransacadicList.GetItem(Index: Integer): TTra_Transacadic;
begin
  Result := TTra_Transacadic(inherited GetItem(Index));
end;

procedure TTra_TransacadicList.SetItem(Index: Integer; Value: TTra_Transacadic);
begin
  inherited SetItem(Index, Value);
end;

end.