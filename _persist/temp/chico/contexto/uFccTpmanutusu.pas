unit uFccTpmanutusu;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcc_Tpmanutusu = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Usuliberado: String;
    fTp_Manutencao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Versaldo: String;
    fIn_Ocultarmov: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Usuliberado : String read fCd_Usuliberado write fCd_Usuliberado;
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Versaldo : String read fIn_Versaldo write fIn_Versaldo;
    property In_Ocultarmov : String read fIn_Ocultarmov write fIn_Ocultarmov;
  end;

  TFcc_Tpmanutusus = class(TList)
  public
    function Add: TFcc_Tpmanutusu; overload;
  end;

implementation

{ TFcc_Tpmanutusu }

constructor TFcc_Tpmanutusu.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcc_Tpmanutusu.Destroy;
begin

  inherited;
end;

//--

function TFcc_Tpmanutusu.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCC_TPMANUTUSU';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Usuliberado', 'CD_USULIBERADO', tfKey);
    Add('Tp_Manutencao', 'TP_MANUTENCAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Versaldo', 'IN_VERSALDO', tfNul);
    Add('In_Ocultarmov', 'IN_OCULTARMOV', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcc_Tpmanutusus }

function TFcc_Tpmanutusus.Add: TFcc_Tpmanutusu;
begin
  Result := TFcc_Tpmanutusu.Create(nil);
  Self.Add(Result);
end;

end.