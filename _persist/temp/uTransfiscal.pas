unit uTransfiscal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransfiscal = class(TmMapping)
  private
    fCd_Dnatrans: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Ambiente: Integer;
    fTp_Emissao: Integer;
    fTp_Modalidade: Integer;
    fTp_Operacao: Integer;
    fTp_Docfiscal: Integer;
    fNr_Docfiscal: Integer;
    fCd_Serie: String;
    fDh_Emissao: String;
    fDh_Entradasaida: String;
    fDs_Chave: String;
    fDh_Recibo: String;
    fNr_Recibo: String;
    fTp_Processamento: String;
    procedure SetCd_Dnatrans(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : String);
    procedure SetTp_Ambiente(const Value : Integer);
    procedure SetTp_Emissao(const Value : Integer);
    procedure SetTp_Modalidade(const Value : Integer);
    procedure SetTp_Operacao(const Value : Integer);
    procedure SetTp_Docfiscal(const Value : Integer);
    procedure SetNr_Docfiscal(const Value : Integer);
    procedure SetCd_Serie(const Value : String);
    procedure SetDh_Emissao(const Value : String);
    procedure SetDh_Entradasaida(const Value : String);
    procedure SetDs_Chave(const Value : String);
    procedure SetDh_Recibo(const Value : String);
    procedure SetNr_Recibo(const Value : String);
    procedure SetTp_Processamento(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Dnatrans : String read fCd_Dnatrans write SetCd_Dnatrans;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Ambiente : Integer read fTp_Ambiente write SetTp_Ambiente;
    property Tp_Emissao : Integer read fTp_Emissao write SetTp_Emissao;
    property Tp_Modalidade : Integer read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Operacao : Integer read fTp_Operacao write SetTp_Operacao;
    property Tp_Docfiscal : Integer read fTp_Docfiscal write SetTp_Docfiscal;
    property Nr_Docfiscal : Integer read fNr_Docfiscal write SetNr_Docfiscal;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Dh_Emissao : String read fDh_Emissao write SetDh_Emissao;
    property Dh_Entradasaida : String read fDh_Entradasaida write SetDh_Entradasaida;
    property Ds_Chave : String read fDs_Chave write SetDs_Chave;
    property Dh_Recibo : String read fDh_Recibo write SetDh_Recibo;
    property Nr_Recibo : String read fNr_Recibo write SetNr_Recibo;
    property Tp_Processamento : String read fTp_Processamento write SetTp_Processamento;
  end;

  TTransfiscals = class(TList)
  public
    function Add: TTransfiscal; overload;
  end;

implementation

{ TTransfiscal }

constructor TTransfiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransfiscal.Destroy;
begin

  inherited;
end;

//--

function TTransfiscal.GetMapping: PmMapping;
begin
  with Result.Tabela do begin
    Nome := 'TRANSFISCAL';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Dnatrans', 'CD_DNATRANS');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Tp_Ambiente', 'TP_AMBIENTE');
    Add('Tp_Emissao', 'TP_EMISSAO');
    Add('Tp_Modalidade', 'TP_MODALIDADE');
    Add('Tp_Operacao', 'TP_OPERACAO');
    Add('Tp_Docfiscal', 'TP_DOCFISCAL');
    Add('Nr_Docfiscal', 'NR_DOCFISCAL');
    Add('Cd_Serie', 'CD_SERIE');
    Add('Dh_Emissao', 'DH_EMISSAO');
    Add('Dh_Entradasaida', 'DH_ENTRADASAIDA');
    Add('Ds_Chave', 'DS_CHAVE');
    Add('Dh_Recibo', 'DH_RECIBO');
    Add('Nr_Recibo', 'NR_RECIBO');
    Add('Tp_Processamento', 'TP_PROCESSAMENTO');
  end;
end;

//--

procedure TTransfiscal.SetCd_Dnatrans(const Value : String);
begin
  fCd_Dnatrans := Value;
end;

procedure TTransfiscal.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TTransfiscal.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TTransfiscal.SetDt_Cadastro(const Value : String);
begin
  fDt_Cadastro := Value;
end;

procedure TTransfiscal.SetTp_Ambiente(const Value : Integer);
begin
  fTp_Ambiente := Value;
end;

procedure TTransfiscal.SetTp_Emissao(const Value : Integer);
begin
  fTp_Emissao := Value;
end;

procedure TTransfiscal.SetTp_Modalidade(const Value : Integer);
begin
  fTp_Modalidade := Value;
end;

procedure TTransfiscal.SetTp_Operacao(const Value : Integer);
begin
  fTp_Operacao := Value;
end;

procedure TTransfiscal.SetTp_Docfiscal(const Value : Integer);
begin
  fTp_Docfiscal := Value;
end;

procedure TTransfiscal.SetNr_Docfiscal(const Value : Integer);
begin
  fNr_Docfiscal := Value;
end;

procedure TTransfiscal.SetCd_Serie(const Value : String);
begin
  fCd_Serie := Value;
end;

procedure TTransfiscal.SetDh_Emissao(const Value : String);
begin
  fDh_Emissao := Value;
end;

procedure TTransfiscal.SetDh_Entradasaida(const Value : String);
begin
  fDh_Entradasaida := Value;
end;

procedure TTransfiscal.SetDs_Chave(const Value : String);
begin
  fDs_Chave := Value;
end;

procedure TTransfiscal.SetDh_Recibo(const Value : String);
begin
  fDh_Recibo := Value;
end;

procedure TTransfiscal.SetNr_Recibo(const Value : String);
begin
  fNr_Recibo := Value;
end;

procedure TTransfiscal.SetTp_Processamento(const Value : String);
begin
  fTp_Processamento := Value;
end;

{ TTransfiscals }

function TTransfiscals.Add: TTransfiscal;
begin
  Result := TTransfiscal.Create(nil);
  Self.Add(Result);
end;

end.