unit uTraTroca;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Troca = class(TmMapping)
  private
    fCd_Empdev: String;
    fNr_Tradev: String;
    fDt_Tradev: String;
    fCd_Empven: String;
    fNr_Traven: String;
    fDt_Traven: String;
    fU_Version: String;
    fCd_Empfatdev: String;
    fCd_Grupoempdev: String;
    fCd_Empfatven: String;
    fCd_Grupoempven: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Difitem: String;
    fQt_Difpecas: String;
    fVl_Diferenca: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empdev : String read fCd_Empdev write fCd_Empdev;
    property Nr_Tradev : String read fNr_Tradev write fNr_Tradev;
    property Dt_Tradev : String read fDt_Tradev write fDt_Tradev;
    property Cd_Empven : String read fCd_Empven write fCd_Empven;
    property Nr_Traven : String read fNr_Traven write fNr_Traven;
    property Dt_Traven : String read fDt_Traven write fDt_Traven;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfatdev : String read fCd_Empfatdev write fCd_Empfatdev;
    property Cd_Grupoempdev : String read fCd_Grupoempdev write fCd_Grupoempdev;
    property Cd_Empfatven : String read fCd_Empfatven write fCd_Empfatven;
    property Cd_Grupoempven : String read fCd_Grupoempven write fCd_Grupoempven;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Nr_Difitem : String read fNr_Difitem write fNr_Difitem;
    property Qt_Difpecas : String read fQt_Difpecas write fQt_Difpecas;
    property Vl_Diferenca : String read fVl_Diferenca write fVl_Diferenca;
  end;

  TTra_Trocas = class(TList)
  public
    function Add: TTra_Troca; overload;
  end;

implementation

{ TTra_Troca }

constructor TTra_Troca.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Troca.Destroy;
begin

  inherited;
end;

//--

function TTra_Troca.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TROCA';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empdev', 'CD_EMPDEV', tfKey);
    Add('Nr_Tradev', 'NR_TRADEV', tfKey);
    Add('Dt_Tradev', 'DT_TRADEV', tfKey);
    Add('Cd_Empven', 'CD_EMPVEN', tfKey);
    Add('Nr_Traven', 'NR_TRAVEN', tfKey);
    Add('Dt_Traven', 'DT_TRAVEN', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Empfatdev', 'CD_EMPFATDEV', tfReq);
    Add('Cd_Grupoempdev', 'CD_GRUPOEMPDEV', tfReq);
    Add('Cd_Empfatven', 'CD_EMPFATVEN', tfReq);
    Add('Cd_Grupoempven', 'CD_GRUPOEMPVEN', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Nr_Difitem', 'NR_DIFITEM', tfNul);
    Add('Qt_Difpecas', 'QT_DIFPECAS', tfNul);
    Add('Vl_Diferenca', 'VL_DIFERENCA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Trocas }

function TTra_Trocas.Add: TTra_Troca;
begin
  Result := TTra_Troca.Create(nil);
  Self.Add(Result);
end;

end.