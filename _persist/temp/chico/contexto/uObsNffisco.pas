unit uObsNffisco;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TObs_Nffisco = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Observacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write fDt_Fatura;
    property Nr_Linha : String read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : String read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TObs_Nffiscos = class(TList)
  public
    function Add: TObs_Nffisco; overload;
  end;

implementation

{ TObs_Nffisco }

constructor TObs_Nffisco.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TObs_Nffisco.Destroy;
begin

  inherited;
end;

//--

function TObs_Nffisco.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'OBS_NFFISCO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Fatura', 'NR_FATURA', tfKey);
    Add('Dt_Fatura', 'DT_FATURA', tfKey);
    Add('Nr_Linha', 'NR_LINHA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfat', 'CD_EMPFAT', tfReq);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Ds_Observacao', 'DS_OBSERVACAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TObs_Nffiscos }

function TObs_Nffiscos.Add: TObs_Nffisco;
begin
  Result := TObs_Nffisco.Create(nil);
  Self.Add(Result);
end;

end.