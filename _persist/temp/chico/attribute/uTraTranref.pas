unit uTraTranref;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('TRA_TRANREF')]
  TTra_Tranref = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_TRANSACAO', tfKey)]
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    [Campo('DT_TRANSACAO', tfKey)]
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    [Campo('CD_EMPRESANFREF', tfKey)]
    property Cd_Empresanfref : String read fCd_Empresanfref write fCd_Empresanfref;
    [Campo('NR_FATURANFREF', tfKey)]
    property Nr_Faturanfref : String read fNr_Faturanfref write fNr_Faturanfref;
    [Campo('DT_FATURANFREF', tfKey)]
    property Dt_Faturanfref : String read fDt_Faturanfref write fDt_Faturanfref;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_REFERENCIAL', tfNul)]
    property Tp_Referencial : String read fTp_Referencial write fTp_Referencial;
  end;

  TTra_Tranrefs = class(TList<Tra_Tranref>);

implementation

{ TTra_Tranref }

constructor TTra_Tranref.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Tranref.Destroy;
begin

  inherited;
end;

end.