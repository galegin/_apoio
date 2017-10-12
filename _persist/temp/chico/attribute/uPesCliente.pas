unit uPesCliente;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_CLIENTE')]
  TPes_Cliente = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_CLIENTE', tfKey)]
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('TP_FORMAPGTO', tfReq)]
    property Tp_Formapgto : String read fTp_Formapgto write fTp_Formapgto;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_BLOQUEADO', tfNul)]
    property In_Bloqueado : String read fIn_Bloqueado write fIn_Bloqueado;
    [Campo('IN_CNSRFINAL', tfNul)]
    property In_Cnsrfinal : String read fIn_Cnsrfinal write fIn_Cnsrfinal;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('NR_SUFRAMA', tfNul)]
    property Nr_Suframa : String read fNr_Suframa write fNr_Suframa;
    [Campo('NR_CODIGOFISCAL', tfNul)]
    property Nr_Codigofiscal : String read fNr_Codigofiscal write fNr_Codigofiscal;
  end;

  TPes_Clientes = class(TList<Pes_Cliente>);

implementation

{ TPes_Cliente }

constructor TPes_Cliente.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Cliente.Destroy;
begin

  inherited;
end;

end.