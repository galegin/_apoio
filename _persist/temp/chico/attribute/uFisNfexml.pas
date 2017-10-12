unit uFisNfexml;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_NFEXML')]
  TFis_Nfexml = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NR_FATURA', tfKey)]
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    [Campo('DT_FATURA', tfKey)]
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_AMBIENTE', tfReq)]
    property Tp_Ambiente : String read fTp_Ambiente write fTp_Ambiente;
    [Campo('TP_EMISSAO', tfReq)]
    property Tp_Emissao : String read fTp_Emissao write fTp_Emissao;
    [Campo('DS_ENVIOXML', tfReq)]
    property Ds_Envioxml : String read fDs_Envioxml write fDs_Envioxml;
    [Campo('DS_RETORNOXML', tfNul)]
    property Ds_Retornoxml : String read fDs_Retornoxml write fDs_Retornoxml;
  end;

  TFis_Nfexmls = class(TList<Fis_Nfexml>);

implementation

{ TFis_Nfexml }

constructor TFis_Nfexml.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Nfexml.Destroy;
begin

  inherited;
end;

end.