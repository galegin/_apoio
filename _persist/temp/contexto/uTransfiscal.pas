unit uTransfiscal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransfiscal = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fTp_Operacao: Integer;
    fTp_Modalidade: Integer;
    fTp_Modelonf: Integer;
    fCd_Serie: String;
    fNr_Nf: Integer;
    fTp_Processamento: String;
    fDs_Chaveacesso: String;
    fDt_Recebimento: TDateTime;
    fNr_Recibo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Operacao : Integer read fTp_Operacao write fTp_Operacao;
    property Tp_Modalidade : Integer read fTp_Modalidade write fTp_Modalidade;
    property Tp_Modelonf : Integer read fTp_Modelonf write fTp_Modelonf;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Nr_Nf : Integer read fNr_Nf write fNr_Nf;
    property Tp_Processamento : String read fTp_Processamento write fTp_Processamento;
    property Ds_Chaveacesso : String read fDs_Chaveacesso write fDs_Chaveacesso;
    property Dt_Recebimento : TDateTime read fDt_Recebimento write fDt_Recebimento;
    property Nr_Recibo : String read fNr_Recibo write fNr_Recibo;
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
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSFISCAL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Tp_Operacao', 'TP_OPERACAO', ftReq);
    Add('Tp_Modalidade', 'TP_MODALIDADE', ftReq);
    Add('Tp_Modelonf', 'TP_MODELONF', ftReq);
    Add('Cd_Serie', 'CD_SERIE', ftReq);
    Add('Nr_Nf', 'NR_NF', ftReq);
    Add('Tp_Processamento', 'TP_PROCESSAMENTO', ftReq);
    Add('Ds_Chaveacesso', 'DS_CHAVEACESSO', ftNul);
    Add('Dt_Recebimento', 'DT_RECEBIMENTO', ftNul);
    Add('Nr_Recibo', 'NR_RECIBO', ftNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTransfiscals }

function TTransfiscals.Add: TTransfiscal;
begin
  Result := TTransfiscal.Create(nil);
  Self.Add(Result);
end;

end.