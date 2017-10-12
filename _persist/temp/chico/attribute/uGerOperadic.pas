unit uGerOperadic;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_OPERADIC')]
  TGer_Operadic = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfNul)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_CALCCUSTOCONTABIL', tfNul)]
    property Tp_Calccustocontabil : String read fTp_Calccustocontabil write fTp_Calccustocontabil;
    [Campo('TP_VALIDASALDO', tfNul)]
    property Tp_Validasaldo : String read fTp_Validasaldo write fTp_Validasaldo;
    [Campo('TP_CONTABILIZACAO', tfNul)]
    property Tp_Contabilizacao : String read fTp_Contabilizacao write fTp_Contabilizacao;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('TP_VALIDASALDONEG', tfNul)]
    property Tp_Validasaldoneg : String read fTp_Validasaldoneg write fTp_Validasaldoneg;
    [Campo('TP_MODDCTONF', tfNul)]
    property Tp_Moddctonf : String read fTp_Moddctonf write fTp_Moddctonf;
    [Campo('IN_ESTTRANSITO', tfNul)]
    property In_Esttransito : String read fIn_Esttransito write fIn_Esttransito;
    [Campo('TP_FINALIDADENFE', tfNul)]
    property Tp_Finalidadenfe : String read fTp_Finalidadenfe write fTp_Finalidadenfe;
    [Campo('TP_INDPRES', tfNul)]
    property Tp_Indpres : String read fTp_Indpres write fTp_Indpres;
    [Campo('TP_IMPDANFE', tfNul)]
    property Tp_Impdanfe : String read fTp_Impdanfe write fTp_Impdanfe;
  end;

  TGer_Operadics = class(TList<Ger_Operadic>);

implementation

{ TGer_Operadic }

constructor TGer_Operadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Operadic.Destroy;
begin

  inherited;
end;

end.