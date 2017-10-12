unit uPesEmpclidesc;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Empclidesc = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Cliente: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Descmax: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Pr_Descmax : String read fPr_Descmax write fPr_Descmax;
  end;

  TPes_Empclidescs = class(TList)
  public
    function Add: TPes_Empclidesc; overload;
  end;

implementation

{ TPes_Empclidesc }

constructor TPes_Empclidesc.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Empclidesc.Destroy;
begin

  inherited;
end;

//--

function TPes_Empclidesc.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_EMPCLIDESC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Cliente', 'CD_CLIENTE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Descmax', 'PR_DESCMAX', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Empclidescs }

function TPes_Empclidescs.Add: TPes_Empclidesc;
begin
  Result := TPes_Empclidesc.Create(nil);
  Self.Add(Result);
end;

end.