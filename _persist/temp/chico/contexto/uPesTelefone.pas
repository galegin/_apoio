unit uPesTelefone;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Telefone = class(TmMapping)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipofone: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Telefone: String;
    fIn_Padrao: String;
    fNr_Ramal: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipofone : String read fCd_Tipofone write fCd_Tipofone;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Nr_Ramal : String read fNr_Ramal write fNr_Ramal;
  end;

  TPes_Telefones = class(TList)
  public
    function Add: TPes_Telefone; overload;
  end;

implementation

{ TPes_Telefone }

constructor TPes_Telefone.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Telefone.Destroy;
begin

  inherited;
end;

//--

function TPes_Telefone.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_TELEFONE';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Tipofone', 'CD_TIPOFONE', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nr_Telefone', 'NR_TELEFONE', tfNul);
    Add('In_Padrao', 'IN_PADRAO', tfNul);
    Add('Nr_Ramal', 'NR_RAMAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Telefones }

function TPes_Telefones.Add: TPes_Telefone;
begin
  Result := TPes_Telefone.Create(nil);
  Self.Add(Result);
end;

end.