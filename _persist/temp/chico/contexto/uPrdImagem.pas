unit uPrdImagem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Imagem = class(TmMapping)
  private
    fCd_Imagem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Imagem: String;
    fDs_Imagem: String;
    fDs_Arquivo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Imagem : String read fCd_Imagem write fCd_Imagem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Imagem : String read fNm_Imagem write fNm_Imagem;
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
    property Ds_Arquivo : String read fDs_Arquivo write fDs_Arquivo;
  end;

  TPrd_Imagems = class(TList)
  public
    function Add: TPrd_Imagem; overload;
  end;

implementation

{ TPrd_Imagem }

constructor TPrd_Imagem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Imagem.Destroy;
begin

  inherited;
end;

//--

function TPrd_Imagem.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_IMAGEM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Imagem', 'CD_IMAGEM', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nm_Imagem', 'NM_IMAGEM', tfReq);
    Add('Ds_Imagem', 'DS_IMAGEM', tfNul);
    Add('Ds_Arquivo', 'DS_ARQUIVO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Imagems }

function TPrd_Imagems.Add: TPrd_Imagem;
begin
  Result := TPrd_Imagem.Create(nil);
  Self.Add(Result);
end;

end.