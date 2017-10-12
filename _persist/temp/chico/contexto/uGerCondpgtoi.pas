unit uGerCondpgtoi;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TGer_Condpgtoi = class(TmMapping)
  private
    fCd_Condpgto: String;
    fNr_Seq4: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fQt_Dia: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Condpgto : String read fCd_Condpgto write fCd_Condpgto;
    property Nr_Seq4 : String read fNr_Seq4 write fNr_Seq4;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Qt_Dia : String read fQt_Dia write fQt_Dia;
  end;

  TGer_Condpgtois = class(TList)
  public
    function Add: TGer_Condpgtoi; overload;
  end;

implementation

{ TGer_Condpgtoi }

constructor TGer_Condpgtoi.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TGer_Condpgtoi.Destroy;
begin

  inherited;
end;

//--

function TGer_Condpgtoi.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'GER_CONDPGTOI';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Condpgto', 'CD_CONDPGTO', tfKey);
    Add('Nr_Seq4', 'NR_SEQ4', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Qt_Dia', 'QT_DIA', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TGer_Condpgtois }

function TGer_Condpgtois.Add: TGer_Condpgtoi;
begin
  Result := TGer_Condpgtoi.Create(nil);
  Self.Add(Result);
end;

end.