unit uTraTranref;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TTra_Tranref = class(TmMapping)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fCd_Empresanfref: String;
    fNr_Faturanfref: String;
    fDt_Faturanfref: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Referencial: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write fDt_Transacao;
    property Cd_Empresanfref : String read fCd_Empresanfref write fCd_Empresanfref;
    property Nr_Faturanfref : String read fNr_Faturanfref write fNr_Faturanfref;
    property Dt_Faturanfref : String read fDt_Faturanfref write fDt_Faturanfref;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Referencial : String read fTp_Referencial write fTp_Referencial;
  end;

  TTra_Tranrefs = class(TList)
  public
    function Add: TTra_Tranref; overload;
  end;

implementation

{ TTra_Tranref }

constructor TTra_Tranref.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TTra_Tranref.Destroy;
begin

  inherited;
end;

//--

function TTra_Tranref.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'TRA_TRANREF';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Nr_Transacao', 'NR_TRANSACAO', tfKey);
    Add('Dt_Transacao', 'DT_TRANSACAO', tfKey);
    Add('Cd_Empresanfref', 'CD_EMPRESANFREF', tfKey);
    Add('Nr_Faturanfref', 'NR_FATURANFREF', tfKey);
    Add('Dt_Faturanfref', 'DT_FATURANFREF', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Referencial', 'TP_REFERENCIAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TTra_Tranrefs }

function TTra_Tranrefs.Add: TTra_Tranref;
begin
  Result := TTra_Tranref.Create(nil);
  Self.Add(Result);
end;

end.