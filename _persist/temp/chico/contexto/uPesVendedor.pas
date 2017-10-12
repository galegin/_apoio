unit uPesVendedor;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Vendedor = class(TmMapping)
  private
    fCd_Vendedor: String;
    fU_Version: String;
    fCd_Pessoa: String;
    fNm_Vendedor: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nm_Vendedor : String read fNm_Vendedor write fNm_Vendedor;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_Vendedors = class(TList)
  public
    function Add: TPes_Vendedor; overload;
  end;

implementation

{ TPes_Vendedor }

constructor TPes_Vendedor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Vendedor.Destroy;
begin

  inherited;
end;

//--

function TPes_Vendedor.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_VENDEDOR';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Vendedor', 'CD_VENDEDOR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Pessoa', 'CD_PESSOA', tfNul);
    Add('Nm_Vendedor', 'NM_VENDEDOR', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Vendedors }

function TPes_Vendedors.Add: TPes_Vendedor;
begin
  Result := TPes_Vendedor.Create(nil);
  Self.Add(Result);
end;

end.