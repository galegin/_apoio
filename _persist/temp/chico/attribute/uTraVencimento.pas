unit uTraVencimento;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_VENCIMENTO')]
  TTra_Vencimento = class(TmMapping)
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
    [Campo('NR_PARCELA', tfKey)]
    property Nr_Parcela : String read fNr_Parcela write fNr_Parcela;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_EMPFAT', tfReq)]
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DT_VENCIMENTO', tfReq)]
    property Dt_Vencimento : String read fDt_Vencimento write fDt_Vencimento;
    [Campo('DT_BAIXA', tfNul)]
    property Dt_Baixa : String read fDt_Baixa write fDt_Baixa;
    [Campo('NR_DCTOORIGEM', tfNul)]
    property Nr_Dctoorigem : String read fNr_Dctoorigem write fNr_Dctoorigem;
    [Campo('VL_PARCELA', tfNul)]
    property Vl_Parcela : String read fVl_Parcela write fVl_Parcela;
    [Campo('TP_FORMAPGTO', tfNul)]
    property Tp_Formapgto : String read fTp_Formapgto write fTp_Formapgto;
  end;

  TTra_Vencimentos = class(TList<Tra_Vencimento>);

implementation

{ TTra_Vencimento }

constructor TTra_Vencimento.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Vencimento.Destroy;
begin

  inherited;
end;

end.