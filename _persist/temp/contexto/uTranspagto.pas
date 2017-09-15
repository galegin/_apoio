unit uTranspagto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTranspagto = class(TmMapping)
  private
    fId_Transacao: String;
    fNr_Seq: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Caixa: Integer;
    fTp_Documento: Integer;
    fId_Histrel: Integer;
    fNr_Parcela: Integer;
    fNr_Parcelas: Integer;
    fNr_Documento: Integer;
    fVl_Documento: Real;
    fDt_Vencimento: TDateTime;
    fCd_Autorizacao: String;
    fNr_Nsu: Integer;
    fDs_Redetef: String;
    fNm_Operadora: String;
    fNr_Banco: Integer;
    fNr_Agencia: Integer;
    fDs_Conta: String;
    fNr_Cheque: Integer;
    fDs_Cmc7: String;
    fTp_Baixa: Integer;
    fCd_Operbaixa: Integer;
    fDt_Baixa: TDateTime;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property Nr_Seq : Integer read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Id_Caixa : Integer read fId_Caixa write fId_Caixa;
    property Tp_Documento : Integer read fTp_Documento write fTp_Documento;
    property Id_Histrel : Integer read fId_Histrel write fId_Histrel;
    property Nr_Parcela : Integer read fNr_Parcela write fNr_Parcela;
    property Nr_Parcelas : Integer read fNr_Parcelas write fNr_Parcelas;
    property Nr_Documento : Integer read fNr_Documento write fNr_Documento;
    property Vl_Documento : Real read fVl_Documento write fVl_Documento;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
    property Cd_Autorizacao : String read fCd_Autorizacao write fCd_Autorizacao;
    property Nr_Nsu : Integer read fNr_Nsu write fNr_Nsu;
    property Ds_Redetef : String read fDs_Redetef write fDs_Redetef;
    property Nm_Operadora : String read fNm_Operadora write fNm_Operadora;
    property Nr_Banco : Integer read fNr_Banco write fNr_Banco;
    property Nr_Agencia : Integer read fNr_Agencia write fNr_Agencia;
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    property Nr_Cheque : Integer read fNr_Cheque write fNr_Cheque;
    property Ds_Cmc7 : String read fDs_Cmc7 write fDs_Cmc7;
    property Tp_Baixa : Integer read fTp_Baixa write fTp_Baixa;
    property Cd_Operbaixa : Integer read fCd_Operbaixa write fCd_Operbaixa;
    property Dt_Baixa : TDateTime read fDt_Baixa write fDt_Baixa;
  end;

  TTranspagtos = class(TList)
  public
    function Add: TTranspagto; overload;
  end;

implementation

{ TTranspagto }

constructor TTranspagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTranspagto.Destroy;
begin

  inherited;
end;

//--

function TTranspagto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSPAGTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', ftKey);
    Add('Nr_Seq', 'NR_SEQ', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Id_Caixa', 'ID_CAIXA', ftReq);
    Add('Tp_Documento', 'TP_DOCUMENTO', ftReq);
    Add('Id_Histrel', 'ID_HISTREL', ftReq);
    Add('Nr_Parcela', 'NR_PARCELA', ftReq);
    Add('Nr_Parcelas', 'NR_PARCELAS', ftReq);
    Add('Nr_Documento', 'NR_DOCUMENTO', ftNul);
    Add('Vl_Documento', 'VL_DOCUMENTO', ftReq);
    Add('Dt_Vencimento', 'DT_VENCIMENTO', ftReq);
    Add('Cd_Autorizacao', 'CD_AUTORIZACAO', ftNul);
    Add('Nr_Nsu', 'NR_NSU', ftNul);
    Add('Ds_Redetef', 'DS_REDETEF', ftNul);
    Add('Nm_Operadora', 'NM_OPERADORA', ftNul);
    Add('Nr_Banco', 'NR_BANCO', ftNul);
    Add('Nr_Agencia', 'NR_AGENCIA', ftNul);
    Add('Ds_Conta', 'DS_CONTA', ftNul);
    Add('Nr_Cheque', 'NR_CHEQUE', ftNul);
    Add('Ds_Cmc7', 'DS_CMC7', ftNul);
    Add('Tp_Baixa', 'TP_BAIXA', ftNul);
    Add('Cd_Operbaixa', 'CD_OPERBAIXA', ftNul);
    Add('Dt_Baixa', 'DT_BAIXA', ftNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTranspagtos }

function TTranspagtos.Add: TTranspagto;
begin
  Result := TTranspagto.Create(nil);
  Self.Add(Result);
end;

end.