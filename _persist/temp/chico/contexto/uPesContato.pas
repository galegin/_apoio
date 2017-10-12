unit uPesContato;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Contato = class(TmMapping)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipocontato: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Contato: String;
    fNr_Telefone: String;
    fDs_Funcao: String;
    fDs_Email: String;
    fDt_Nascimento: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipocontato : String read fCd_Tipocontato write fCd_Tipocontato;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nm_Contato : String read fNm_Contato write fNm_Contato;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property Ds_Funcao : String read fDs_Funcao write fDs_Funcao;
    property Ds_Email : String read fDs_Email write fDs_Email;
    property Dt_Nascimento : String read fDt_Nascimento write fDt_Nascimento;
  end;

  TPes_Contatos = class(TList)
  public
    function Add: TPes_Contato; overload;
  end;

implementation

{ TPes_Contato }

constructor TPes_Contato.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Contato.Destroy;
begin

  inherited;
end;

//--

function TPes_Contato.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_CONTATO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('Nr_Sequencia', 'NR_SEQUENCIA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Tipocontato', 'CD_TIPOCONTATO', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nm_Contato', 'NM_CONTATO', tfReq);
    Add('Nr_Telefone', 'NR_TELEFONE', tfNul);
    Add('Ds_Funcao', 'DS_FUNCAO', tfNul);
    Add('Ds_Email', 'DS_EMAIL', tfNul);
    Add('Dt_Nascimento', 'DT_NASCIMENTO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Contatos }

function TPes_Contatos.Add: TPes_Contato;
begin
  Result := TPes_Contato.Create(nil);
  Self.Add(Result);
end;

end.