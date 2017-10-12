unit uPesContato;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_CONTATO')]
  TPes_Contato = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('NR_SEQUENCIA', tfKey)]
    property Nr_Sequencia : String read fNr_Sequencia write fNr_Sequencia;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_TIPOCONTATO', tfReq)]
    property Cd_Tipocontato : String read fCd_Tipocontato write fCd_Tipocontato;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NM_CONTATO', tfReq)]
    property Nm_Contato : String read fNm_Contato write fNm_Contato;
    [Campo('NR_TELEFONE', tfNul)]
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    [Campo('DS_FUNCAO', tfNul)]
    property Ds_Funcao : String read fDs_Funcao write fDs_Funcao;
    [Campo('DS_EMAIL', tfNul)]
    property Ds_Email : String read fDs_Email write fDs_Email;
    [Campo('DT_NASCIMENTO', tfNul)]
    property Dt_Nascimento : String read fDt_Nascimento write fDt_Nascimento;
  end;

  TPes_Contatos = class(TList<Pes_Contato>);

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

end.