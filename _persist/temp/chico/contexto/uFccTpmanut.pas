unit uFccTpmanut;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFcc_Tpmanut = class(TmMapping)
  private
    fTp_Manutencao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Manutencao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Tp_Manutencao : String read fTp_Manutencao write fTp_Manutencao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Manutencao : String read fDs_Manutencao write fDs_Manutencao;
  end;

  TFcc_Tpmanuts = class(TList)
  public
    function Add: TFcc_Tpmanut; overload;
  end;

implementation

{ TFcc_Tpmanut }

constructor TFcc_Tpmanut.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcc_Tpmanut.Destroy;
begin

  inherited;
end;

//--

function TFcc_Tpmanut.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FCC_TPMANUT';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Tp_Manutencao', 'TP_MANUTENCAO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Manutencao', 'DS_MANUTENCAO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFcc_Tpmanuts }

function TFcc_Tpmanuts.Add: TFcc_Tpmanut;
begin
  Result := TFcc_Tpmanut.Create(nil);
  Self.Add(Result);
end;

end.