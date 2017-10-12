unit uPrdPromocao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Promocao = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Promocao: String;
    fU_Version: String;
    fDs_Promocao: String;
    fTp_Situacao: String;
    fTp_Valor: String;
    fCd_Valor: String;
    fDt_Inicio: String;
    fDt_Final: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Prazomedio: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    property U_Version : String read fU_Version write fU_Version;
    property Ds_Promocao : String read fDs_Promocao write fDs_Promocao;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    property Dt_Inicio : String read fDt_Inicio write fDt_Inicio;
    property Dt_Final : String read fDt_Final write fDt_Final;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nr_Prazomedio : String read fNr_Prazomedio write fNr_Prazomedio;
  end;

  TPrd_Promocaos = class(TList)
  public
    function Add: TPrd_Promocao; overload;
  end;

implementation

{ TPrd_Promocao }

constructor TPrd_Promocao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Promocao.Destroy;
begin

  inherited;
end;

//--

function TPrd_Promocao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PROMOCAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Promocao', 'CD_PROMOCAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Ds_Promocao', 'DS_PROMOCAO', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Tp_Valor', 'TP_VALOR', tfReq);
    Add('Cd_Valor', 'CD_VALOR', tfReq);
    Add('Dt_Inicio', 'DT_INICIO', tfReq);
    Add('Dt_Final', 'DT_FINAL', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nr_Prazomedio', 'NR_PRAZOMEDIO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Promocaos }

function TPrd_Promocaos.Add: TPrd_Promocao;
begin
  Result := TPrd_Promocao.Create(nil);
  Self.Add(Result);
end;

end.