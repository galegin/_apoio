unit uGerModnfc;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Modnfc = class(TmMapping)
  private
    fCd_Modelonf: String;
    fU_Version: String;
    fCd_Serie: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Modelonf: String;
    fNr_Colunas: String;
    fNr_Linhas: String;
    fNr_Itens: String;
    fNr_Vlunitdec: String;
    fNr_Qtunitdec: String;
    fNm_Job: String;
    fIn_Quebranf: String;
    fIn_Agrupa_Grupo: String;
    fTp_Codproduto: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Modelonf : String read fCd_Modelonf write fCd_Modelonf;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Modelonf : String read fDs_Modelonf write fDs_Modelonf;
    property Nr_Colunas : String read fNr_Colunas write fNr_Colunas;
    property Nr_Linhas : String read fNr_Linhas write fNr_Linhas;
    property Nr_Itens : String read fNr_Itens write fNr_Itens;
    property Nr_Vlunitdec : String read fNr_Vlunitdec write fNr_Vlunitdec;
    property Nr_Qtunitdec : String read fNr_Qtunitdec write fNr_Qtunitdec;
    property Nm_Job : String read fNm_Job write fNm_Job;
    property In_Quebranf : String read fIn_Quebranf write fIn_Quebranf;
    property In_Agrupa_Grupo : String read fIn_Agrupa_Grupo write fIn_Agrupa_Grupo;
    property Tp_Codproduto : String read fTp_Codproduto write fTp_Codproduto;
  end;

  TGer_Modnfcs = class(TList)
  public
    function Add: TGer_Modnfc; overload;
  end;

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

//--

function TGer_Modnfc.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_MODNFC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Modelonf', 'CD_MODELONF', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Serie', 'CD_SERIE', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Modelonf', 'DS_MODELONF', tfReq);
    Add('Nr_Colunas', 'NR_COLUNAS', tfNul);
    Add('Nr_Linhas', 'NR_LINHAS', tfNul);
    Add('Nr_Itens', 'NR_ITENS', tfNul);
    Add('Nr_Vlunitdec', 'NR_VLUNITDEC', tfNul);
    Add('Nr_Qtunitdec', 'NR_QTUNITDEC', tfNul);
    Add('Nm_Job', 'NM_JOB', tfNul);
    Add('In_Quebranf', 'IN_QUEBRANF', tfNul);
    Add('In_Agrupa_Grupo', 'IN_AGRUPA_GRUPO', tfNul);
    Add('Tp_Codproduto', 'TP_CODPRODUTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Modnfcs }

function TGer_Modnfcs.Add: TGer_Modnfc;
begin
  Result := TGer_Modnfc.Create(nil);
  Self.Add(Result);
end;

end.