unit uFisCst;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Cst = class(TmMapping)
  private
    fCd_Cst: String;
    fU_Version: String;
    fTp_Cst: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Regimesub: String;
    fIn_Calcicms: String;
    fDs_Cst: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Cst : String read fTp_Cst write fTp_Cst;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    property In_Calcicms : String read fIn_Calcicms write fIn_Calcicms;
    property Ds_Cst : String read fDs_Cst write fDs_Cst;
  end;

  TFis_Csts = class(TList)
  public
    function Add: TFis_Cst; overload;
  end;

implementation

{ TFis_Cst }

constructor TFis_Cst.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Cst.Destroy;
begin

  inherited;
end;

//--

function TFis_Cst.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_CST';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cst', 'CD_CST', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Tp_Cst', 'TP_CST', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Regimesub', 'TP_REGIMESUB', tfNul);
    Add('In_Calcicms', 'IN_CALCICMS', tfNul);
    Add('Ds_Cst', 'DS_CST', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Csts }

function TFis_Csts.Add: TFis_Cst;
begin
  Result := TFis_Cst.Create(nil);
  Self.Add(Result);
end;

end.