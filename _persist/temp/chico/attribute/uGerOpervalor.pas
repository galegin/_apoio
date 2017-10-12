unit uGerOpervalor;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_OPERVALOR')]
  TGer_Opervalor = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_OPERACAO', tfKey)]
    property Cd_Operacao : String read fCd_Operacao write fCd_Operacao;
    [Campo('TP_UNIDVALOR', tfKey)]
    property Tp_Unidvalor : String read fTp_Unidvalor write fTp_Unidvalor;
    [Campo('CD_UNIDVALOR', tfKey)]
    property Cd_Unidvalor : String read fCd_Unidvalor write fCd_Unidvalor;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_PRECOBASE', tfNul)]
    property In_Precobase : String read fIn_Precobase write fIn_Precobase;
  end;

  TGer_Opervalors = class(TList<Ger_Opervalor>);

implementation

{ TGer_Opervalor }

constructor TGer_Opervalor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Opervalor.Destroy;
begin

  inherited;
end;

end.