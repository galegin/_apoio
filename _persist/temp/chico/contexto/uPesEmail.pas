unit uPesEmail;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Email = class(TmMapping)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipoemail: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Email: String;
    fIn_Padrao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipoemail : String read fCd_Tipoemail write fCd_Tipoemail;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Email : String read fDs_Email write fDs_Email;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
  end;

  TPes_Emails = class(TList)
  public
    function Add: TPes_Email; overload;
  end;

implementation

{ TPes_Email }

constructor TPes_Email.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Email.Destroy;
begin

  inherited;
end;

//--

function TPes_Email.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_EMAIL';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Tipoemail', 'CD_TIPOEMAIL', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Email', 'DS_EMAIL', tfReq);
    Add('In_Padrao', 'IN_PADRAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Emails }

function TPes_Emails.Add: TPes_Email;
begin
  Result := TPes_Email.Create(nil);
  Self.Add(Result);
end;

end.