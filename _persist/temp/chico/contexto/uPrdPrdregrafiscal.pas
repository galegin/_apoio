unit uPrdPrdregrafiscal;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Prdregrafiscal = class(TmMapping)
  private
    fCd_Produto: String;
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Regrafiscal: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_Prdregrafiscals = class(TList)
  public
    function Add: TPrd_Prdregrafiscal; overload;
  end;

implementation

{ TPrd_Prdregrafiscal }

constructor TPrd_Prdregrafiscal.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Prdregrafiscal.Destroy;
begin

  inherited;
end;

//--

function TPrd_Prdregrafiscal.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PRDREGRAFISCAL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('Cd_Operacao', 'CD_OPERACAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Prdregrafiscals }

function TPrd_Prdregrafiscals.Add: TPrd_Prdregrafiscal;
begin
  Result := TPrd_Prdregrafiscal.Create(nil);
  Self.Add(Result);
end;

end.