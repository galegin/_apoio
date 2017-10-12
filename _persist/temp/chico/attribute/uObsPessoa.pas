unit uObsPessoa;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('OBS_PESSOA')]
  TObs_Pessoa = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('NR_LINHA', tfKey)]
    property Nr_Linha : String read fNr_Linha write fNr_Linha;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_MANUTENCAO', tfNul)]
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    [Campo('CD_COMPONENTE', tfNul)]
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    [Campo('DS_OBSERVACAO', tfNul)]
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_Pessoas = class(TList<Obs_Pessoa>);

implementation

{ TObs_Pessoa }

constructor TObs_Pessoa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TObs_Pessoa.Destroy;
begin

  inherited;
end;

end.