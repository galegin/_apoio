unit uPrdCor;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Cor = class(TmMapping)
  private
    fCd_Cor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Cor: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cor : String read fCd_Cor write fCd_Cor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Cor : String read fDs_Cor write fDs_Cor;
  end;

  TPrd_Cors = class(TList)
  public
    function Add: TPrd_Cor; overload;
  end;

implementation

{ TPrd_Cor }

constructor TPrd_Cor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Cor.Destroy;
begin

  inherited;
end;

//--

function TPrd_Cor.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_COR';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cor', 'CD_COR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Cor', 'DS_COR', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Cors }

function TPrd_Cors.Add: TPrd_Cor;
begin
  Result := TPrd_Cor.Create(nil);
  Self.Add(Result);
end;

end.