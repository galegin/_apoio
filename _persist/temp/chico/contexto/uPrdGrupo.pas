unit uPrdGrupo;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Grupo = class(TmMapping)
  private
    fCd_Seq: String;
    fU_Version: String;
    fCd_Grupo: String;
    fCd_Seqpai: String;
    fCd_Produto: String;
    fCd_Grade: String;
    fCd_Tipoclas: String;
    fDt_Cadastro: String;
    fCd_Operador: String;
    fDs_Grupo: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Seq : String read fCd_Seq write fCd_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupo : String read fCd_Grupo write fCd_Grupo;
    property Cd_Seqpai : String read fCd_Seqpai write fCd_Seqpai;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Ds_Grupo : String read fDs_Grupo write fDs_Grupo;
  end;

  TPrd_Grupos = class(TList)
  public
    function Add: TPrd_Grupo; overload;
  end;

implementation

{ TPrd_Grupo }

constructor TPrd_Grupo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Grupo.Destroy;
begin

  inherited;
end;

//--

function TPrd_Grupo.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_GRUPO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Seq', 'CD_SEQ', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Grupo', 'CD_GRUPO', tfReq);
    Add('Cd_Seqpai', 'CD_SEQPAI', tfNul);
    Add('Cd_Produto', 'CD_PRODUTO', tfNul);
    Add('Cd_Grade', 'CD_GRADE', tfReq);
    Add('Cd_Tipoclas', 'CD_TIPOCLAS', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Ds_Grupo', 'DS_GRUPO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Grupos }

function TPrd_Grupos.Add: TPrd_Grupo;
begin
  Result := TPrd_Grupo.Create(nil);
  Self.Add(Result);
end;

end.