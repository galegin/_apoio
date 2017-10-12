unit uTraTransacadic;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TRANSACADIC')]
  TTra_Transacadic = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DT_INCLUSAO', tfNul)]
    property Dt_Inclusao : String read fDt_Inclusao write fDt_Inclusao;
    [Campo('CD_USUEMAIL', tfNul)]
    property Cd_Usuemail : String read fCd_Usuemail write fCd_Usuemail;
    [Campo('DT_ULTEMAIL', tfNul)]
    property Dt_Ultemail : String read fDt_Ultemail write fDt_Ultemail;
    [Campo('DS_PARAULTEMAIL', tfNul)]
    property Ds_Paraultemail : String read fDs_Paraultemail write fDs_Paraultemail;
    [Campo('NR_ENVIOEMAIL', tfNul)]
    property Nr_Envioemail : String read fNr_Envioemail write fNr_Envioemail;
    [Campo('NR_PRAZOMEDIO', tfNul)]
    property Nr_Prazomedio : String read fNr_Prazomedio write fNr_Prazomedio;
    [Campo('NM_CHECKOUT', tfNul)]
    property Nm_Checkout : String read fNm_Checkout write fNm_Checkout;
    [Campo('DT_BASEPARCELA', tfNul)]
    property Dt_Baseparcela : String read fDt_Baseparcela write fDt_Baseparcela;
    [Campo('CD_TABPRECO', tfNul)]
    property Cd_Tabpreco : String read fCd_Tabpreco write fCd_Tabpreco;
    [Campo('CD_CCUSTO', tfNul)]
    property Cd_Ccusto : String read fCd_Ccusto write fCd_Ccusto;
    [Campo('CD_EMPAGRUP', tfNul)]
    property Cd_Empagrup : String read fCd_Empagrup write fCd_Empagrup;
    [Campo('CD_AGRUPADOR', tfNul)]
    property Cd_Agrupador : String read fCd_Agrupador write fCd_Agrupador;
    [Campo('CD_DESPESA', tfNul)]
    property Cd_Despesa : String read fCd_Despesa write fCd_Despesa;
    [Campo('CD_PESSOAPROP', tfNul)]
    property Cd_Pessoaprop : String read fCd_Pessoaprop write fCd_Pessoaprop;
    [Campo('CD_PROPRIEDADE', tfNul)]
    property Cd_Propriedade : String read fCd_Propriedade write fCd_Propriedade;
    [Campo('TP_BONUSDESC', tfNul)]
    property Tp_Bonusdesc : String read fTp_Bonusdesc write fTp_Bonusdesc;
    [Campo('VL_BONUSDESC', tfNul)]
    property Vl_Bonusdesc : String read fVl_Bonusdesc write fVl_Bonusdesc;
    [Campo('VL_BASEBONUSDESC', tfNul)]
    property Vl_Basebonusdesc : String read fVl_Basebonusdesc write fVl_Basebonusdesc;
    [Campo('CD_FAMILIAR', tfNul)]
    property Cd_Familiar : String read fCd_Familiar write fCd_Familiar;
    [Campo('PR_SIMULADOR', tfNul)]
    property Pr_Simulador : String read fPr_Simulador write fPr_Simulador;
    [Campo('VL_SIMULADOR', tfNul)]
    property Vl_Simulador : String read fVl_Simulador write fVl_Simulador;
  end;

  TTra_Transacadics = class(TList<Tra_Transacadic>);

implementation

{ TTra_Transacadic }

constructor TTra_Transacadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Transacadic.Destroy;
begin

  inherited;
end;

end.