unit uPrdGrupo;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PRD_GRUPO')]
  TPrd_Grupo = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_SEQ', tfKey)]
    property Cd_Seq : String read fCd_Seq write fCd_Seq;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_GRUPO', tfReq)]
    property Cd_Grupo : String read fCd_Grupo write fCd_Grupo;
    [Campo('CD_SEQPAI', tfNul)]
    property Cd_Seqpai : String read fCd_Seqpai write fCd_Seqpai;
    [Campo('CD_PRODUTO', tfNul)]
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    [Campo('CD_GRADE', tfReq)]
    property Cd_Grade : String read fCd_Grade write fCd_Grade;
    [Campo('CD_TIPOCLAS', tfReq)]
    property Cd_Tipoclas : String read fCd_Tipoclas write fCd_Tipoclas;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DS_GRUPO', tfReq)]
    property Ds_Grupo : String read fDs_Grupo write fDs_Grupo;
  end;

  TPrd_Grupos = class(TList<Prd_Grupo>);

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

end.