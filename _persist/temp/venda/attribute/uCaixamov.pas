unit uCaixamov;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('CAIXAMOV')]
  TCaixamov = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('ID_CAIXA', tfKey)]
    property Id_Caixa : Integer read fId_Caixa write fId_Caixa;
    [Campo('NR_SEQ', tfKey)]
    property Nr_Seq : Integer read fNr_Seq write fNr_Seq;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_LANCTO', tfReq)]
    property Tp_Lancto : Integer read fTp_Lancto write fTp_Lancto;
    [Campo('VL_LANCTO', tfReq)]
    property Vl_Lancto : String read fVl_Lancto write fVl_Lancto;
    [Campo('NR_DOC', tfReq)]
    property Nr_Doc : Integer read fNr_Doc write fNr_Doc;
    [Campo('DS_AUX', tfReq)]
    property Ds_Aux : String read fDs_Aux write fDs_Aux;
  end;

  TCaixamovs = class(TList<Caixamov>);

implementation

{ TCaixamov }

constructor TCaixamov.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TCaixamov.Destroy;
begin

  inherited;
end;

end.