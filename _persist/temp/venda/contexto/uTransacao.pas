unit uTransacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTransacao = class(TmMapping)
  private
    fId_Transacao: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Empresa: Integer;
    fId_Pessoa: String;
    fId_Operacao: String;
    fDt_Transacao: String;
    fNr_Transacao: Integer;
    fTp_Situacao: Integer;
    fDt_Cancelamento: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Transacao : String read fId_Transacao write fId_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Id_Empresa : Integer read fId_Empresa write fId_Empresa;
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
    property Id_Operacao : String read fId_Operacao write fId_Operacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Nr_Transacao : Integer read fNr_Transacao write fNr_Transacao;
    property Tp_Situacao : Integer read fTp_Situacao write fTp_Situacao;
    property Dt_Cancelamento : String read fDt_Cancelamento write fDt_Cancelamento;
  end;

  TTransacaos = class(TList)
  public
    function Add: TTransacao; overload;
  end;

implementation

{ TTransacao }

constructor TTransacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTransacao.Destroy;
begin

  inherited;
end;

//--

function TTransacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRANSACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Transacao', 'ID_TRANSACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Id_Empresa', 'ID_EMPRESA', tfReq);
    Add('Id_Pessoa', 'ID_PESSOA', tfReq);
    Add('Id_Operacao', 'ID_OPERACAO', tfReq);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfReq);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Dt_Cancelamento', 'DT_CANCELAMENTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTransacaos }

function TTransacaos.Add: TTransacao;
begin
  Result := TTransacao.Create(nil);
  Self.Add(Result);
end;

end.