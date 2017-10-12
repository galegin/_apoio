unit uPesCliadic;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Cliadic = class(TmMapping)
  private
    fCd_Cliente: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Vectolimite: String;
    fIn_Restrito: String;
    fCd_Conceito: String;
    fCd_Tabdesc: String;
    fNr_Diabasevencto: String;
    fNr_Diascarencia: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Dt_Vectolimite : String read fDt_Vectolimite write fDt_Vectolimite;
    property In_Restrito : String read fIn_Restrito write fIn_Restrito;
    property Cd_Conceito : String read fCd_Conceito write fCd_Conceito;
    property Cd_Tabdesc : String read fCd_Tabdesc write fCd_Tabdesc;
    property Nr_Diabasevencto : String read fNr_Diabasevencto write fNr_Diabasevencto;
    property Nr_Diascarencia : String read fNr_Diascarencia write fNr_Diascarencia;
  end;

  TPes_Cliadics = class(TList)
  public
    function Add: TPes_Cliadic; overload;
  end;

implementation

{ TPes_Cliadic }

constructor TPes_Cliadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Cliadic.Destroy;
begin

  inherited;
end;

//--

function TPes_Cliadic.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_CLIADIC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Cliente', 'CD_CLIENTE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Dt_Vectolimite', 'DT_VECTOLIMITE', tfNul);
    Add('In_Restrito', 'IN_RESTRITO', tfNul);
    Add('Cd_Conceito', 'CD_CONCEITO', tfNul);
    Add('Cd_Tabdesc', 'CD_TABDESC', tfNul);
    Add('Nr_Diabasevencto', 'NR_DIABASEVENCTO', tfNul);
    Add('Nr_Diascarencia', 'NR_DIASCARENCIA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Cliadics }

function TPes_Cliadics.Add: TPes_Cliadic;
begin
  Result := TPes_Cliadic.Create(nil);
  Self.Add(Result);
end;

end.