unit uTraPagto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Pagto = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Documento: String;
    fNr_Histrelsub: String;
    fNr_Documento: String;
    fVl_Documento: String;
    fDt_Vencimento: String;
    fCd_Autorizacao: String;
    fNr_Nsu: String;
    fDs_Redetef: String;
    fNr_Parcela: String;
    fNr_Parcelas: String;
    fNr_Banco: String;
    fNr_Agencia: String;
    fDs_Conta: String;
    fNr_Cheque: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    property Nr_Histrelsub : String read fNr_Histrelsub write fNr_Histrelsub;
    property Nr_Documento : String read fNr_Documento write fNr_Documento;
    property Vl_Documento : String read fVl_Documento write fVl_Documento;
    property Dt_Vencimento : String read fDt_Vencimento write fDt_Vencimento;
    property Cd_Autorizacao : String read fCd_Autorizacao write fCd_Autorizacao;
    property Nr_Nsu : String read fNr_Nsu write fNr_Nsu;
    property Ds_Redetef : String read fDs_Redetef write fDs_Redetef;
    property Nr_Parcela : String read fNr_Parcela write fNr_Parcela;
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    property Nr_Banco : String read fNr_Banco write fNr_Banco;
    property Nr_Agencia : String read fNr_Agencia write fNr_Agencia;
    property Ds_Conta : String read fDs_Conta write fDs_Conta;
    property Nr_Cheque : String read fNr_Cheque write fNr_Cheque;
  end;

  TTra_Pagtos = class(TList)
  public
    function Add: TTra_Pagto; overload;
  end;

implementation

{ TTra_Pagto }

constructor TTra_Pagto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Pagto.Destroy;
begin

  inherited;
end;

//--

function TTra_Pagto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_PAGTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Documento', 'TP_DOCUMENTO', tfReq);
    Add('Nr_Histrelsub', 'NR_HISTRELSUB', tfReq);
    Add('Nr_Documento', 'NR_DOCUMENTO', tfReq);
    Add('Vl_Documento', 'VL_DOCUMENTO', tfReq);
    Add('Dt_Vencimento', 'DT_VENCIMENTO', tfReq);
    Add('Cd_Autorizacao', 'CD_AUTORIZACAO', tfNul);
    Add('Nr_Nsu', 'NR_NSU', tfNul);
    Add('Ds_Redetef', 'DS_REDETEF', tfNul);
    Add('Nr_Parcela', 'NR_PARCELA', tfNul);
    Add('Nr_Parcelas', 'NR_PARCELAS', tfNul);
    Add('Nr_Banco', 'NR_BANCO', tfNul);
    Add('Nr_Agencia', 'NR_AGENCIA', tfNul);
    Add('Ds_Conta', 'DS_CONTA', tfNul);
    Add('Nr_Cheque', 'NR_CHEQUE', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Pagtos }

function TTra_Pagtos.Add: TTra_Pagto;
begin
  Result := TTra_Pagto.Create(nil);
  Self.Add(Result);
end;

end.