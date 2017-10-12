unit uTraTransacadic;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Transacadic = class;
  TTra_TransacadicClass = class of TTra_Transacadic;

  TTra_TransacadicList = class;
  TTra_TransacadicListClass = class of TTra_TransacadicList;

  TTra_Transacadic = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Inclusao: String;
    fCd_Usuemail: String;
    fDt_Ultemail: String;
    fDs_Paraultemail: String;
    fNr_Envioemail: String;
    fNr_Prazomedio: String;
    fNm_Checkout: String;
    fDt_Baseparcela: String;
    fCd_Tabpreco: String;
    fCd_Ccusto: String;
    fCd_Empagrup: String;
    fCd_Agrupador: String;
    fCd_Despesa: String;
    fCd_Pessoaprop: String;
    fCd_Propriedade: String;
    fTp_Bonusdesc: String;
    fVl_Bonusdesc: String;
    fVl_Basebonusdesc: String;
    fCd_Familiar: String;
    fPr_Simulador: String;
    fVl_Simulador: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Inclusao : String read fDt_Inclusao write SetDt_Inclusao;
    property Cd_Usuemail : String read fCd_Usuemail write SetCd_Usuemail;
    property Dt_Ultemail : String read fDt_Ultemail write SetDt_Ultemail;
    property Ds_Paraultemail : String read fDs_Paraultemail write SetDs_Paraultemail;
    property Nr_Envioemail : String read fNr_Envioemail write SetNr_Envioemail;
    property Nr_Prazomedio : String read fNr_Prazomedio write SetNr_Prazomedio;
    property Nm_Checkout : String read fNm_Checkout write SetNm_Checkout;
    property Dt_Baseparcela : String read fDt_Baseparcela write SetDt_Baseparcela;
    property Cd_Tabpreco : String read fCd_Tabpreco write SetCd_Tabpreco;
    property Cd_Ccusto : String read fCd_Ccusto write SetCd_Ccusto;
    property Cd_Empagrup : String read fCd_Empagrup write SetCd_Empagrup;
    property Cd_Agrupador : String read fCd_Agrupador write SetCd_Agrupador;
    property Cd_Despesa : String read fCd_Despesa write SetCd_Despesa;
    property Cd_Pessoaprop : String read fCd_Pessoaprop write SetCd_Pessoaprop;
    property Cd_Propriedade : String read fCd_Propriedade write SetCd_Propriedade;
    property Tp_Bonusdesc : String read fTp_Bonusdesc write SetTp_Bonusdesc;
    property Vl_Bonusdesc : String read fVl_Bonusdesc write SetVl_Bonusdesc;
    property Vl_Basebonusdesc : String read fVl_Basebonusdesc write SetVl_Basebonusdesc;
    property Cd_Familiar : String read fCd_Familiar write SetCd_Familiar;
    property Pr_Simulador : String read fPr_Simulador write SetPr_Simulador;
    property Vl_Simulador : String read fVl_Simulador write SetVl_Simulador;
  end;

  TTra_TransacadicList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Transacadic;
    procedure SetItem(Index: Integer; Value: TTra_Transacadic);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Transacadic;
    property Items[Index: Integer]: TTra_Transacadic read GetItem write SetItem; default;
  end;

implementation

{ TTra_Transacadic }

constructor TTra_Transacadic.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Transacadic.Destroy;
begin

  inherited;
end;

{ TTra_TransacadicList }

constructor TTra_TransacadicList.Create(AOwner: TPersistentCollection);
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