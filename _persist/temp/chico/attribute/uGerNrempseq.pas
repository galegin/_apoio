unit uGerNrempseq;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('GER_NREMPSEQ')]
  TGer_Nrempseq = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('NM_ENTIDADE', tfKey)]
    property Nm_Entidade : String read fNm_Entidade write fNm_Entidade;
    [Campo('NM_ATRIBUTO', tfKey)]
    property Nm_Atributo : String read fNm_Atributo write fNm_Atributo;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('NR_INCREMENTO', tfReq)]
    property Nr_Incremento : String read fNr_Incremento write fNr_Incremento;
    [Campo('NR_ATUAL', tfReq)]
    property Nr_Atual : String read fNr_Atual write fNr_Atual;
    [Campo('NR_INICIAL', tfReq)]
    property Nr_Inicial : String read fNr_Inicial write fNr_Inicial;
    [Campo('NR_FINAL', tfReq)]
    property Nr_Final : String read fNr_Final write fNr_Final;
    [Campo('IN_REINICIAR', tfNul)]
    property In_Reiniciar : String read fIn_Reiniciar write fIn_Reiniciar;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_Nrempseqs = class(TList<Ger_Nrempseq>);

implementation

{ TGer_Nrempseq }

constructor TGer_Nrempseq.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Nrempseq.Destroy;
begin

  inherited;
end;

end.