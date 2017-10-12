unit uGerModnfc;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_MODNFC')]
  TGer_Modnfc = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_MODELONF', tfKey)]
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_SERIE', tfReq)]
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_MODELONF', tfReq)]
    property Ds_Modelonf : String read fDs_Modelonf write fDs_Modelonf;
    [Campo('NR_COLUNAS', tfNul)]
    property Nr_Colunas : String read fNr_Colunas write fNr_Colunas;
    [Campo('NR_LINHAS', tfNul)]
    property Nr_Linhas : String read fNr_Linhas write fNr_Linhas;
    [Campo('NR_ITENS', tfNul)]
    property Nr_Itens : String read fNr_Itens write fNr_Itens;
    [Campo('NR_VLUNITDEC', tfNul)]
    property Nr_Vlunitdec : String read fNr_Vlunitdec write fNr_Vlunitdec;
    [Campo('NR_QTUNITDEC', tfNul)]
    property Nr_Qtunitdec : String read fNr_Qtunitdec write fNr_Qtunitdec;
    [Campo('NM_JOB', tfNul)]
    property Nm_Job : String read fNm_Job write fNm_Job;
    [Campo('IN_QUEBRANF', tfNul)]
    property In_Quebranf : String read fIn_Quebranf write fIn_Quebranf;
    [Campo('IN_AGRUPA_GRUPO', tfNul)]
    property In_Agrupa_Grupo : String read fIn_Agrupa_Grupo write fIn_Agrupa_Grupo;
    [Campo('TP_CODPRODUTO', tfNul)]
    property Tp_Codproduto : String read fTp_Codproduto write fTp_Codproduto;
  end;

  TGer_Modnfcs = class(TList<Ger_Modnfc>);

implementation

{ TGer_Modnfc }

constructor TGer_Modnfc.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Modnfc.Destroy;
begin

  inherited;
end;

end.