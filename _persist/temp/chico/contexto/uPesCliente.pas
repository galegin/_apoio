unit uPesCliente;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Cliente = class(TmMapping)
  private
    fCd_Cliente: String;
    fU_Version: String;
    fTp_Formapgto: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Bloqueado: String;
    fIn_Cnsrfinal: String;
    fIn_Inativo: String;
    fNr_Suframa: String;
    fNr_Codigofiscal: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Formapgto : String read fTp_Formapgto write fTp_Formapgto;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Bloqueado : String read fIn_Bloqueado write fIn_Bloqueado;
    property In_Cnsrfinal : String read fIn_Cnsrfinal write fIn_Cnsrfinal;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property Nr_Suframa : String read fNr_Suframa write fNr_Suframa;
    property Nr_Codigofiscal : String read fNr_Codigofiscal write fNr_Codigofiscal;
  end;

  TPes_Clientes = class(TList)
  public
    function Add: TPes_Cliente; overload;
  end;

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

//--

function TPes_Cliente.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_CLIENTE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cliente', 'CD_CLIENTE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Tp_Formapgto', 'TP_FORMAPGTO', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Bloqueado', 'IN_BLOQUEADO', tfNul);
    Add('In_Cnsrfinal', 'IN_CNSRFINAL', tfNul);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('Nr_Suframa', 'NR_SUFRAMA', tfNul);
    Add('Nr_Codigofiscal', 'NR_CODIGOFISCAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Clientes }

function TPes_Clientes.Add: TPes_Cliente;
begin
  Result := TPes_Cliente.Create(nil);
  Self.Add(Result);
end;

end.