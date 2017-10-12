unit uFisNfeinut;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Nfeinut = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Moddoctofiscal: String;
    fCd_Serie: String;
    fNr_Nf: String;
    fDt_Recebimento: String;
    fNr_Recibo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Moddoctofiscal : String read fTp_Moddoctofiscal write fTp_Moddoctofiscal;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Nr_Nf : String read fNr_Nf write fNr_Nf;
    property Dt_Recebimento : String read fDt_Recebimento write fDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
  end;

  TFis_Nfeinuts = class(TList)
  public
    function Add: TFis_Nfeinut; overload;
  end;

implementation

{ TFis_Nfeinut }

constructor TFis_Nfeinut.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfeinut.Destroy;
begin

  inherited;
end;

//--

function TFis_Nfeinut.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_NFEINUT';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Moddoctofiscal', 'TP_MODDOCTOFISCAL', tfReq);
    Add('Cd_Serie', 'CD_SERIE', tfReq);
    Add('Nr_Nf', 'NR_NF', tfReq);
    Add('Dt_Recebimento', 'DT_RECEBIMENTO', tfReq);
    Add('Nr_Recibo', 'NR_RECIBO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Nfeinuts }

function TFis_Nfeinuts.Add: TFis_Nfeinut;
begin
  Result := TFis_Nfeinut.Create(nil);
  Self.Add(Result);
end;

end.