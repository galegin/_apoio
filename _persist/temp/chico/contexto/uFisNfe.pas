unit uFisNfe;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Nfe = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Chaveacesso: String;
    fTp_Processamento: String;
    fNr_Recibo: String;
    fDt_Recebimento: String;
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
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    property Tp_Processamento : String read fTp_Processamento write fTp_Processamento;
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
    property Dt_Recebimento : String read fDt_Recebimento write fDt_Recebimento;
  end;

  TFis_Nfes = class(TList)
  public
    function Add: TFis_Nfe; overload;
  end;

implementation

{ TFis_Nfe }

constructor TFis_Nfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfe.Destroy;
begin

  inherited;
end;

//--

function TFis_Nfe.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_NFE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Chaveacesso', 'DS_CHAVEACESSO', tfReq);
    Add('Tp_Processamento', 'TP_PROCESSAMENTO', tfNul);
    Add('Nr_Recibo', 'NR_RECIBO', tfNul);
    Add('Dt_Recebimento', 'DT_RECEBIMENTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Nfes }

function TFis_Nfes.Add: TFis_Nfe;
begin
  Result := TFis_Nfe.Create(nil);
  Self.Add(Result);
end;

end.