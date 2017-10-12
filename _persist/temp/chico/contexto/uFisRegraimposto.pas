unit uFisRegraimposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Regraimposto = class(TmMapping)
  private
    fCd_Imposto: String;
    fCd_Regrafiscal: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Cst: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write fCd_Regrafiscal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Cd_Cst : String read fCd_Cst write fCd_Cst;
  end;

  TFis_Regraimpostos = class(TList)
  public
    function Add: TFis_Regraimposto; overload;
  end;

implementation

{ TFis_Regraimposto }

constructor TFis_Regraimposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Regraimposto.Destroy;
begin

  inherited;
end;

//--

function TFis_Regraimposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_REGRAIMPOSTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Imposto', 'CD_IMPOSTO', tfKey);
    Add('Cd_Regrafiscal', 'CD_REGRAFISCAL', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Cd_Cst', 'CD_CST', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Regraimpostos }

function TFis_Regraimpostos.Add: TFis_Regraimposto;
begin
  Result := TFis_Regraimposto.Create(nil);
  Self.Add(Result);
end;

end.