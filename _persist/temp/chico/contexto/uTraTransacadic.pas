unit uTraTransacadic;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Transacadic = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Dt_Inclusao : String read fDt_Inclusao write fDt_Inclusao;
    property Cd_Usuemail : String read fCd_Usuemail write fCd_Usuemail;
    property Dt_Ultemail : String read fDt_Ultemail write fDt_Ultemail;
    property Ds_Paraultemail : String read fDs_Paraultemail write fDs_Paraultemail;
    property Nr_Envioemail : String read fNr_Envioemail write fNr_Envioemail;
    property Nr_Prazomedio : String read fNr_Prazomedio write fNr_Prazomedio;
    property Nm_Checkout : String read fNm_Checkout write fNm_Checkout;
    property Dt_Baseparcela : String read fDt_Baseparcela write fDt_Baseparcela;
    property Cd_Tabpreco : String read fCd_Tabpreco write fCd_Tabpreco;
    property Cd_Ccusto : String read fCd_Ccusto write fCd_Ccusto;
    property Cd_Empagrup : String read fCd_Empagrup write fCd_Empagrup;
    property Cd_Agrupador : String read fCd_Agrupador write fCd_Agrupador;
    property Cd_Despesa : String read fCd_Despesa write fCd_Despesa;
    property Cd_Pessoaprop : String read fCd_Pessoaprop write fCd_Pessoaprop;
    property Cd_Propriedade : String read fCd_Propriedade write fCd_Propriedade;
    property Tp_Bonusdesc : String read fTp_Bonusdesc write fTp_Bonusdesc;
    property Vl_Bonusdesc : String read fVl_Bonusdesc write fVl_Bonusdesc;
    property Vl_Basebonusdesc : String read fVl_Basebonusdesc write fVl_Basebonusdesc;
    property Cd_Familiar : String read fCd_Familiar write fCd_Familiar;
    property Pr_Simulador : String read fPr_Simulador write fPr_Simulador;
    property Vl_Simulador : String read fVl_Simulador write fVl_Simulador;
  end;

  TTra_Transacadics = class(TList)
  public
    function Add: TTra_Transacadic; overload;
  end;

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

//--

function TTra_Transacadic.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TRANSACADIC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Dt_Inclusao', 'DT_INCLUSAO', tfNul);
    Add('Cd_Usuemail', 'CD_USUEMAIL', tfNul);
    Add('Dt_Ultemail', 'DT_ULTEMAIL', tfNul);
    Add('Ds_Paraultemail', 'DS_PARAULTEMAIL', tfNul);
    Add('Nr_Envioemail', 'NR_ENVIOEMAIL', tfNul);
    Add('Nr_Prazomedio', 'NR_PRAZOMEDIO', tfNul);
    Add('Nm_Checkout', 'NM_CHECKOUT', tfNul);
    Add('Dt_Baseparcela', 'DT_BASEPARCELA', tfNul);
    Add('Cd_Tabpreco', 'CD_TABPRECO', tfNul);
    Add('Cd_Ccusto', 'CD_CCUSTO', tfNul);
    Add('Cd_Empagrup', 'CD_EMPAGRUP', tfNul);
    Add('Cd_Agrupador', 'CD_AGRUPADOR', tfNul);
    Add('Cd_Despesa', 'CD_DESPESA', tfNul);
    Add('Cd_Pessoaprop', 'CD_PESSOAPROP', tfNul);
    Add('Cd_Propriedade', 'CD_PROPRIEDADE', tfNul);
    Add('Tp_Bonusdesc', 'TP_BONUSDESC', tfNul);
    Add('Vl_Bonusdesc', 'VL_BONUSDESC', tfNul);
    Add('Vl_Basebonusdesc', 'VL_BASEBONUSDESC', tfNul);
    Add('Cd_Familiar', 'CD_FAMILIAR', tfNul);
    Add('Pr_Simulador', 'PR_SIMULADOR', tfNul);
    Add('Vl_Simulador', 'VL_SIMULADOR', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Transacadics }

function TTra_Transacadics.Add: TTra_Transacadic;
begin
  Result := TTra_Transacadic.Create(nil);
  Self.Add(Result);
end;

end.