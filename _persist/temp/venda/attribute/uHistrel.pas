unit uHistrel;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('HISTREL')]
  THistrel = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_HISTREL', tfKey)]
    property Id_Histrel : Integer read fId_Histrel write fId_Histrel;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_DOCUMENTO', tfReq)]
    property Tp_Documento : Integer read fTp_Documento write fTp_Documento;
    [Campo('CD_HISTREL', tfReq)]
    property Cd_Histrel : Integer read fCd_Histrel write fCd_Histrel;
    [Campo('DS_HISTREL', tfReq)]
    property Ds_Histrel : String read fDs_Histrel write fDs_Histrel;
    [Campo('NR_PARCELAS', tfReq)]
    property Nr_Parcelas : Integer read fNr_Parcelas write fNr_Parcelas;
  end;

  THistrels = class(TList<Histrel>);

implementation

{ THistrel }

constructor THistrel.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor THistrel.Destroy;
begin

  inherited;
end;

end.