unit uFisAliquotaicmsuf;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TFis_Aliquotaicmsuf = class(TmMapping)
  private
    fCd_Uforigem: String;
    fCd_Ufdestino: String;
    fU_Version: String;
    fPr_Aliqicms: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Uforigem : String read fCd_Uforigem write fCd_Uforigem;
    property Cd_Ufdestino : String read fCd_Ufdestino write fCd_Ufdestino;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Aliqicms : String read fPr_Aliqicms write fPr_Aliqicms;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_Aliquotaicmsufs = class(TList)
  public
    function Add: TFis_Aliquotaicmsuf; overload;
  end;

implementation

{ TFis_Aliquotaicmsuf }

constructor TFis_Aliquotaicmsuf.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFis_Aliquotaicmsuf.Destroy;
begin

  inherited;
end;

//--

function TFis_Aliquotaicmsuf.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'FIS_ALIQUOTAICMSUF';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Uforigem', 'CD_UFORIGEM', tfKey);
    Add('Cd_Ufdestino', 'CD_UFDESTINO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Pr_Aliqicms', 'PR_ALIQICMS', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TFis_Aliquotaicmsufs }

function TFis_Aliquotaicmsufs.Add: TFis_Aliquotaicmsuf;
begin
  Result := TFis_Aliquotaicmsuf.Create(nil);
  Self.Add(Result);
end;

end.