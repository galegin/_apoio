unit uFisNfecont;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Nfecont = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Situacao: String;
    fCd_Terminal: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Cd_Terminal : String read fCd_Terminal write fCd_Terminal;
  end;

  TFis_Nfeconts = class(TList)
  public
    function Add: TFis_Nfecont; overload;
  end;

implementation

{ TFis_Nfecont }

constructor TFis_Nfecont.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfecont.Destroy;
begin

  inherited;
end;

//--

function TFis_Nfecont.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_NFECONT';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Situacao', 'TP_SITUACAO', tfReq);
    Add('Cd_Terminal', 'CD_TERMINAL', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Nfeconts }

function TFis_Nfeconts.Add: TFis_Nfecont;
begin
  Result := TFis_Nfecont.Create(nil);
  Self.Add(Result);
end;

end.