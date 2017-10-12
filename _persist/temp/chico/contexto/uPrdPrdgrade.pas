unit uPrdPrdgrade;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Prdgrade = class(TmMapping)
  private
    fCd_Seqgrupo: String;
    fCd_Cor: String;
    fCd_Tamanho: String;
    fU_Version: String;
    fCd_Produto: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Seqgrupo : String read fCd_Seqgrupo write fCd_Seqgrupo;
    property Cd_Cor : String read fCd_Cor write fCd_Cor;
    property Cd_Tamanho : String read fCd_Tamanho write fCd_Tamanho;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Prdgrades = class(TList)
  public
    function Add: TPrd_Prdgrade; overload;
  end;

implementation

{ TPrd_Prdgrade }

constructor TPrd_Prdgrade.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdgrade.Destroy;
begin

  inherited;
end;

//--

function TPrd_Prdgrade.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRDGRADE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Seqgrupo', 'CD_SEQGRUPO', tfKey);
    Add('Cd_Cor', 'CD_COR', tfKey);
    Add('Cd_Tamanho', 'CD_TAMANHO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Produto', 'CD_PRODUTO', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Prdgrades }

function TPrd_Prdgrades.Add: TPrd_Prdgrade;
begin
  Result := TPrd_Prdgrade.Create(nil);
  Self.Add(Result);
end;

end.