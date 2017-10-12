unit uPesClientefpgto;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Clientefpgto = class(TmMapping)
  private
    fCd_Cliente: String;
    fTp_Documento: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    property Tp_Documento : String read fTp_Documento write fTp_Documento;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_Clientefpgtos = class(TList)
  public
    function Add: TPes_Clientefpgto; overload;
  end;

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

//--

function TPes_Clientefpgto.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_CLIENTEFPGTO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cliente', 'CD_CLIENTE', tfKey);
    Add('Tp_Documento', 'TP_DOCUMENTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Clientefpgtos }

function TPes_Clientefpgtos.Add: TPes_Clientefpgto;
begin
  Result := TPes_Clientefpgto.Create(nil);
  Self.Add(Result);
end;

end.