unit uEmpresa;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TEmpresa = class(TmMapping)
  private
    fId_Empresa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fId_Pessoa: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Id_Empresa : Integer read fId_Empresa write fId_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Id_Pessoa : String read fId_Pessoa write fId_Pessoa;
  end;

  TEmpresas = class(TList)
  public
    function Add: TEmpresa; overload;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEmpresa.Destroy;
begin

  inherited;
end;

//--

function TEmpresa.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'EMPRESA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Id_Empresa', 'ID_EMPRESA', ftKey);
    Add('U_Version', 'U_VERSION', ftNul);
    Add('Cd_Operador', 'CD_OPERADOR', ftReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', ftReq);
    Add('Id_Pessoa', 'ID_PESSOA', ftReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TEmpresas }

function TEmpresas.Add: TEmpresa;
begin
  Result := TEmpresa.Create(nil);
  Self.Add(Result);
end;

end.