unit uPrdCodigobarra;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Codigobarra = class(TmMapping)
  private
    fCd_Barraprd: String;
    fU_Version: String;
    fCd_Produto: String;
    fQt_Embalagem: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Padrao: String;
    fTp_Barra: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property Qt_Embalagem : String read fQt_Embalagem write fQt_Embalagem;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Tp_Barra : String read fTp_Barra write fTp_Barra;
  end;

  TPrd_Codigobarras = class(TList)
  public
    function Add: TPrd_Codigobarra; overload;
  end;

implementation

{ TPrd_Codigobarra }

constructor TPrd_Codigobarra.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Codigobarra.Destroy;
begin

  inherited;
end;

//--

function TPrd_Codigobarra.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_CODIGOBARRA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Barraprd', 'CD_BARRAPRD', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Produto', 'CD_PRODUTO', tfReq);
    Add('Qt_Embalagem', 'QT_EMBALAGEM', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('In_Padrao', 'IN_PADRAO', tfNul);
    Add('Tp_Barra', 'TP_BARRA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Codigobarras }

function TPrd_Codigobarras.Add: TPrd_Codigobarra;
begin
  Result := TPrd_Codigobarra.Create(nil);
  Self.Add(Result);
end;

end.