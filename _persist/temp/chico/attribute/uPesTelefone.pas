unit uPesTelefone;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_TELEFONE')]
  TPes_Telefone = class(TmMapping)
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
    [Campo('CD_TIPOFONE', tfReq)]
    property Cd_Tipofone : String read fCd_Tipofone write fCd_Tipofone;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('NR_TELEFONE', tfNul)]
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    [Campo('IN_PADRAO', tfNul)]
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    [Campo('NR_RAMAL', tfNul)]
    property Nr_Ramal : String read fNr_Ramal write fNr_Ramal;
  end;

  TPes_Telefones = class(TList<Pes_Telefone>);

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

end.