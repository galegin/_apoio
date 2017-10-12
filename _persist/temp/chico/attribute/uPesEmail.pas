unit uPesEmail;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_EMAIL')]
  TPes_Email = class(TmMapping)
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
    [Campo('CD_TIPOEMAIL', tfReq)]
    property Cd_Tipoemail : String read fCd_Tipoemail write fCd_Tipoemail;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DS_EMAIL', tfReq)]
    property Ds_Email : String read fDs_Email write fDs_Email;
    [Campo('IN_PADRAO', tfNul)]
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
  end;

  TPes_Emails = class(TList<Pes_Email>);

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

end.