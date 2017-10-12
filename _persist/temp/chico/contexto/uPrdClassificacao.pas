unit uPrdClassificacao;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Classificacao = class(TmMapping)
  private
    fCd_Tipoclas: String;
    fCd_Classificacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Classificacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Classificacao : String read fDs_Classificacao write fDs_Classificacao;
  end;

  TPrd_Classificacaos = class(TList)
  public
    function Add: TPrd_Classificacao; overload;
  end;

implementation

{ TPrd_Classificacao }

constructor TPrd_Classificacao.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Classificacao.Destroy;
begin

  inherited;
end;

//--

function TPrd_Classificacao.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_CLASSIFICACAO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Tipoclas', 'CD_TIPOCLAS', tfKey);
    Add('Cd_Classificacao', 'CD_CLASSIFICACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Classificacao', 'DS_CLASSIFICACAO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Classificacaos }

function TPrd_Classificacaos.Add: TPrd_Classificacao;
begin
  Result := TPrd_Classificacao.Create(nil);
  Self.Add(Result);
end;

end.