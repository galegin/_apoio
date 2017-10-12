unit uPrdTipoclas;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Tipoclas = class(TmMapping)
  private
    fCd_Tipoclas: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tipoclas: String;
    fIn_Grupo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipoclas : String read fDs_Tipoclas write fDs_Tipoclas;
    property In_Grupo : String read fIn_Grupo write fIn_Grupo;
  end;

  TPrd_Tipoclass = class(TList)
  public
    function Add: TPrd_Tipoclas; overload;
  end;

implementation

{ TPrd_Tipoclas }

constructor TPrd_Tipoclas.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Tipoclas.Destroy;
begin

  inherited;
end;

//--

function TPrd_Tipoclas.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_TIPOCLAS';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Tipoclas', 'CD_TIPOCLAS', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Tipoclas', 'DS_TIPOCLAS', tfReq);
    Add('In_Grupo', 'IN_GRUPO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Tipoclass }

function TPrd_Tipoclass.Add: TPrd_Tipoclas;
begin
  Result := TPrd_Tipoclas.Create(nil);
  Self.Add(Result);
end;

end.