unit uPrdTipovalor;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Tipovalor = class(TmMapping)
  private
    fTp_Valor: String;
    fCd_Valor: String;
    fU_Version: String;
    fCd_Moeda: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Valor: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : String read fCd_Valor write fCd_Valor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Moeda : String read fCd_Moeda write fCd_Moeda;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Valor : String read fDs_Valor write fDs_Valor;
  end;

  TPrd_Tipovalors = class(TList)
  public
    function Add: TPrd_Tipovalor; overload;
  end;

implementation

{ TPrd_Tipovalor }

constructor TPrd_Tipovalor.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Tipovalor.Destroy;
begin

  inherited;
end;

//--

function TPrd_Tipovalor.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_TIPOVALOR';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Tp_Valor', 'TP_VALOR', tfKey);
    Add('Cd_Valor', 'CD_VALOR', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Moeda', 'CD_MOEDA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Valor', 'DS_VALOR', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Tipovalors }

function TPrd_Tipovalors.Add: TPrd_Tipovalor;
begin
  Result := TPrd_Tipovalor.Create(nil);
  Self.Add(Result);
end;

end.