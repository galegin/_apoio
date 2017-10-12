unit uPrdGradei;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Gradei = class(TmMapping)
  private
    fCd_Grade: String;
    fCd_Tamanho: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Tamanho: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    property Cd_Tamanho : String read fCd_Tamanho write fCd_Tamanho;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tamanho : String read fDs_Tamanho write fDs_Tamanho;
  end;

  TPrd_Gradeis = class(TList)
  public
    function Add: TPrd_Gradei; overload;
  end;

implementation

{ TPrd_Gradei }

constructor TPrd_Gradei.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Gradei.Destroy;
begin

  inherited;
end;

//--

function TPrd_Gradei.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_GRADEI';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Grade', 'CD_GRADE', tfKey);
    Add('Cd_Tamanho', 'CD_TAMANHO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Tamanho', 'DS_TAMANHO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Gradeis }

function TPrd_Gradeis.Add: TPrd_Gradei;
begin
  Result := TPrd_Gradei.Create(nil);
  Self.Add(Result);
end;

end.