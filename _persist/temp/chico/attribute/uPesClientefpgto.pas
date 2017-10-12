unit uPesClientefpgto;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_CLIENTEFPGTO')]
  TPes_Clientefpgto = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CLIENTE', tfKey)]
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    [Campo('TP_DOCUMENTO', tfKey)]
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_Clientefpgtos = class(TList<Pes_Clientefpgto>);

implementation

{ TPes_Clientefpgto }

constructor TPes_Clientefpgto.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Clientefpgto.Destroy;
begin

  inherited;
end;

end.