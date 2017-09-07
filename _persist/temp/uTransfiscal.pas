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
    function GetTabela() : TmTabela; override;
    function GetKeys() : TmKeys; override;
    function GetCampos() : TmCampos; override;
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

function TTransfiscal.GetTabela: TmTabela;
begin
  Result.Nome := 'TRANSFISCAL';
end;

function TTransfiscal.GetKeys: TmKeys;
begin
  AddKeysResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS']);
end;

function TTransfiscal.GetCampos: TmCampos;
begin
  AddCamposResult(Result, [
    'Cd_Dnatrans|CD_DNATRANS',
    'U_Version|U_VERSION',
    'Cd_Operador|CD_OPERADOR',
    'Dt_Cadastro|DT_CADASTRO',
    'Tp_Ambiente|TP_AMBIENTE',
    'Tp_Emissao|TP_EMISSAO',
    'Tp_Modalidade|TP_MODALIDADE',
    'Tp_Operacao|TP_OPERACAO',
    'Tp_Docfiscal|TP_DOCFISCAL',
    'Nr_Docfiscal|NR_DOCFISCAL',
    'Cd_Serie|CD_SERIE',
    'Dh_Emissao|DH_EMISSAO',
    'Dh_Entradasaida|DH_ENTRADASAIDA',
    'Ds_Chave|DS_CHAVE',
    'Dh_Recibo|DH_RECIBO',
    'Nr_Recibo|NR_RECIBO',
    'Tp_Processamento|TP_PROCESSAMENTO']);
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