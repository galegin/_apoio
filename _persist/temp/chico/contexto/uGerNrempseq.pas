unit uGerNrempseq;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Nrempseq = class(TmMapping)
  private
    fCd_Empresa: String;
    fNm_Entidade: String;
    fNm_Atributo: String;
    fU_Version: String;
    fNr_Incremento: String;
    fNr_Atual: String;
    fNr_Inicial: String;
    fNr_Final: String;
    fIn_Reiniciar: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nm_Entidade : String read fNm_Entidade write fNm_Entidade;
    property Nm_Atributo : String read fNm_Atributo write fNm_Atributo;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Incremento : String read fNr_Incremento write fNr_Incremento;
    property Nr_Atual : String read fNr_Atual write fNr_Atual;
    property Nr_Inicial : String read fNr_Inicial write fNr_Inicial;
    property Nr_Final : String read fNr_Final write fNr_Final;
    property In_Reiniciar : String read fIn_Reiniciar write fIn_Reiniciar;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_Nrempseqs = class(TList)
  public
    function Add: TGer_Nrempseq; overload;
  end;

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

//--

function TGer_Nrempseq.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_NREMPSEQ';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nm_Entidade', 'NM_ENTIDADE', tfKey);
    Add('Nm_Atributo', 'NM_ATRIBUTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Nr_Incremento', 'NR_INCREMENTO', tfReq);
    Add('Nr_Atual', 'NR_ATUAL', tfReq);
    Add('Nr_Inicial', 'NR_INICIAL', tfReq);
    Add('Nr_Final', 'NR_FINAL', tfReq);
    Add('In_Reiniciar', 'IN_REINICIAR', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Nrempseqs }

function TGer_Nrempseqs.Add: TGer_Nrempseq;
begin
  Result := TGer_Nrempseq.Create(nil);
  Self.Add(Result);
end;

end.