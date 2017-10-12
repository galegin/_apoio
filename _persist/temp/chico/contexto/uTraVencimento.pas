unit uTraVencimento;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Vencimento = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Parcela: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Vencimento: String;
    fDt_Baixa: String;
    fNr_Dctoorigem: String;
    fVl_Parcela: String;
    fTp_Formapgto: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Parcela : String read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Dt_Vencimento : String read fDt_Vencimento write fDt_Vencimento;
    property Dt_Baixa : String read fDt_Baixa write fDt_Baixa;
    property Nr_Dctoorigem : String read fNr_Dctoorigem write fNr_Dctoorigem;
    property Vl_Parcela : String read fVl_Parcela write fVl_Parcela;
    property Tp_Formapgto : String read fTp_Formapgto write fTp_Formapgto;
  end;

  TTra_Vencimentos = class(TList)
  public
    function Add: TTra_Vencimento; overload;
  end;

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

//--

function TTra_Vencimento.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_VENCIMENTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('Nr_Parcela', 'NR_PARCELA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Dt_Vencimento', 'DT_VENCIMENTO', tfReq);
    Add('Dt_Baixa', 'DT_BAIXA', tfNul);
    Add('Nr_Dctoorigem', 'NR_DCTOORIGEM', tfNul);
    Add('Vl_Parcela', 'VL_PARCELA', tfNul);
    Add('Tp_Formapgto', 'TP_FORMAPGTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Vencimentos }

function TTra_Vencimentos.Add: TTra_Vencimento;
begin
  Result := TTra_Vencimento.Create(nil);
  Self.Add(Result);
end;

end.