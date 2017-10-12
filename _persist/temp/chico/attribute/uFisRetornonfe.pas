unit uFisRetornonfe;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('FIS_RETORNONFE')]
  TFis_Retornonfe = class(TmMapping)
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
    [Campo('NR_SEQUENCIA', tfKey)]
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_PEDIDO', tfReq)]
    property Tp_Pedido : String read fTp_Pedido write fTp_Pedido;
    [Campo('TP_AMBIENTE', tfReq)]
    property Tp_Ambiente : String read fTp_Ambiente write fTp_Ambiente;
    [Campo('TP_EMISSAO', tfReq)]
    property Tp_Emissao : String read fTp_Emissao write fTp_Emissao;
    [Campo('DS_ENVIOXML', tfReq)]
    property Ds_Envioxml : String read fDs_Envioxml write fDs_Envioxml;
    [Campo('DS_RETORNOXML', tfNul)]
    property Ds_Retornoxml : String read fDs_Retornoxml write fDs_Retornoxml;
  end;

  TFis_Retornonfes = class(TList<Fis_Retornonfe>);

implementation

{ TFis_Retornonfe }

constructor TFis_Retornonfe.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Retornonfe.Destroy;
begin

  inherited;
end;

end.