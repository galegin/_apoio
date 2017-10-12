unit uFisImposto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Imposto = class(TmMapping)
  private
    fCd_Imposto: String;
    fDt_Inivigencia: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fTp_Situacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Imposto : String read fCd_Imposto write fCd_Imposto;
    property Dt_Inivigencia : String read fDt_Inivigencia write fDt_Inivigencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write fPr_Aliquota;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
  end;

  TFis_Impostos = class(TList)
  public
    function Add: TFis_Imposto; overload;
  end;

implementation

{ TFis_Imposto }

constructor TFis_Imposto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Imposto.Destroy;
begin

  inherited;
end;

//--

function TFis_Imposto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_IMPOSTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Imposto', 'CD_IMPOSTO', tfKey);
    Add('Dt_Inivigencia', 'DT_INIVIGENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Aliquota', 'PR_ALIQUOTA', tfNul);
    Add('Tp_Situacao', 'TP_SITUACAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Impostos }

function TFis_Impostos.Add: TFis_Imposto;
begin
  Result := TFis_Imposto.Create(nil);
  Self.Add(Result);
end;

end.