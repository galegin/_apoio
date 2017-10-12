unit uPesVendinfo;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Vendinfo = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Vendedor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Auxiliar: String;
    fIn_Inativo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Vendedor : String read fCd_Vendedor write fCd_Vendedor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Auxiliar : String read fCd_Auxiliar write fCd_Auxiliar;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
  end;

  TPes_Vendinfos = class(TList)
  public
    function Add: TPes_Vendinfo; overload;
  end;

implementation

{ TPes_Vendinfo }

constructor TPes_Vendinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Vendinfo.Destroy;
begin

  inherited;
end;

//--

function TPes_Vendinfo.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_VENDINFO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Vendedor', 'CD_VENDEDOR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Auxiliar', 'CD_AUXILIAR', tfReq);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Vendinfos }

function TPes_Vendinfos.Add: TPes_Vendinfo;
begin
  Result := TPes_Vendinfo.Create(nil);
  Self.Add(Result);
end;

end.