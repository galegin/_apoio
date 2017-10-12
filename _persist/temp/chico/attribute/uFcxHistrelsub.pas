unit uFcxHistrelsub;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FCX_HISTRELSUB')]
  TFcx_Histrelsub = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('TP_DOCUMENTO', tfKey)]
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    [Campo('NR_SEQHISTRELSUB', tfKey)]
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NR_PARCELAS', tfNul)]
    property Nr_Parcelas : String read fNr_Parcelas write fNr_Parcelas;
    [Campo('CD_HISTORICO', tfNul)]
    property Cd_Historico : String read fCd_Historico write fCd_Historico;
    [Campo('CD_HISTFEC', tfNul)]
    property Cd_Histfec : String read fCd_Histfec write fCd_Histfec;
    [Campo('NR_PORTADOR', tfNul)]
    property Nr_Portador : String read fNr_Portador write fNr_Portador;
    [Campo('VL_AUX', tfNul)]
    property Vl_Aux : String read fVl_Aux write fVl_Aux;
    [Campo('DS_HISTRELSUB', tfNul)]
    property Ds_Histrelsub : String read fDs_Histrelsub write fDs_Histrelsub;
    [Campo('CD_FORMULACARTAO', tfNul)]
    property Cd_Formulacartao : String read fCd_Formulacartao write fCd_Formulacartao;
  end;

  TFcx_Histrelsubs = class(TList<Fcx_Histrelsub>);

implementation

{ TFcx_Histrelsub }

constructor TFcx_Histrelsub.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFcx_Histrelsub.Destroy;
begin

  inherited;
end;

end.