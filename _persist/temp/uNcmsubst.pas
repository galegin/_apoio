unit uNcmsubst;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TNcmsubst = class(TmMapping)
  private
    fUf_Origem: String;
    fUf_Destino: String;
    fCd_Ncm: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Cest: String;
    procedure SetUf_Origem(const Value : String);
    procedure SetUf_Destino(const Value : String);
    procedure SetCd_Ncm(const Value : String);
    procedure SetU_Version(const Value : String);
    procedure SetCd_Operador(const Value : Integer);
    procedure SetDt_Cadastro(const Value : TDateTime);
    procedure SetCd_Cest(const Value : String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Uf_Origem : String read fUf_Origem write SetUf_Origem;
    property Uf_Destino : String read fUf_Destino write SetUf_Destino;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Cest : String read fCd_Cest write SetCd_Cest;
  end;

  TNcmsubsts = class(TList)
  public
    function Add: TNcmsubst; overload;
  end;

implementation

{ TNcmsubst }

constructor TNcmsubst.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TNcmsubst.Destroy;
begin

  inherited;
end;

//--

function TNcmsubst.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'NCMSUBST';
  end;

  Result.Chaves := TmChaves.Create;
  with Result.Chaves do begin
    Add('Uf_Origem', 'UF_ORIGEM');
    Add('Uf_Destino', 'UF_DESTINO');
    Add('Cd_Ncm', 'CD_NCM');
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Uf_Origem', 'UF_ORIGEM');
    Add('Uf_Destino', 'UF_DESTINO');
    Add('Cd_Ncm', 'CD_NCM');
    Add('U_Version', 'U_VERSION');
    Add('Cd_Operador', 'CD_OPERADOR');
    Add('Dt_Cadastro', 'DT_CADASTRO');
    Add('Cd_Cest', 'CD_CEST');
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

procedure TNcmsubst.SetUf_Origem(const Value : String);
begin
  fUf_Origem := Value;
end;

procedure TNcmsubst.SetUf_Destino(const Value : String);
begin
  fUf_Destino := Value;
end;

procedure TNcmsubst.SetCd_Ncm(const Value : String);
begin
  fCd_Ncm := Value;
end;

procedure TNcmsubst.SetU_Version(const Value : String);
begin
  fU_Version := Value;
end;

procedure TNcmsubst.SetCd_Operador(const Value : Integer);
begin
  fCd_Operador := Value;
end;

procedure TNcmsubst.SetDt_Cadastro(const Value : TDateTime);
begin
  fDt_Cadastro := Value;
end;

procedure TNcmsubst.SetCd_Cest(const Value : String);
begin
  fCd_Cest := Value;
end;

{ TNcmsubsts }

function TNcmsubsts.Add: TNcmsubst;
begin
  Result := TNcmsubst.Create(nil);
  Self.Add(Result);
end;

end.