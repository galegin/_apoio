unit uFgrFormulacartao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Formulacartao = class;
  TFgr_FormulacartaoClass = class of TFgr_Formulacartao;

  TFgr_FormulacartaoList = class;
  TFgr_FormulacartaoListClass = class of TFgr_FormulacartaoList;

  TFgr_Formulacartao = class(TcCollectionItem)
  private
    fCd_Formulacartao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Gerafatoperadora: String;
    fIn_Diasbaseutil: String;
    fIn_Diasutil: String;
    fIn_Carenciautil: String;
    fIn_Proprio: String;
    fIn_Diafixo: String;
    fNr_Diasbase: Real;
    fNr_Dias: Real;
    fNr_Diascarencia: Real;
    fNr_Locacaodia: Real;
    fPr_Taxa: Real;
    fVl_Taxa: Real;
    fVl_Locacao: Real;
    fDs_Formulacartao: String;
    fIn_Convenio: String;
    fNr_Diaconvenio: Real;
    fIn_Fevereiro28: String;
    fVl_Operacao: Real;
    fIn_Predatado: String;
    fNr_Diasmaxpre: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Formulacartao : Real read fCd_Formulacartao write fCd_Formulacartao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Gerafatoperadora : String read fIn_Gerafatoperadora write fIn_Gerafatoperadora;
    property In_Diasbaseutil : String read fIn_Diasbaseutil write fIn_Diasbaseutil;
    property In_Diasutil : String read fIn_Diasutil write fIn_Diasutil;
    property In_Carenciautil : String read fIn_Carenciautil write fIn_Carenciautil;
    property In_Proprio : String read fIn_Proprio write fIn_Proprio;
    property In_Diafixo : String read fIn_Diafixo write fIn_Diafixo;
    property Nr_Diasbase : Real read fNr_Diasbase write fNr_Diasbase;
    property Nr_Dias : Real read fNr_Dias write fNr_Dias;
    property Nr_Diascarencia : Real read fNr_Diascarencia write fNr_Diascarencia;
    property Nr_Locacaodia : Real read fNr_Locacaodia write fNr_Locacaodia;
    property Pr_Taxa : Real read fPr_Taxa write fPr_Taxa;
    property Vl_Taxa : Real read fVl_Taxa write fVl_Taxa;
    property Vl_Locacao : Real read fVl_Locacao write fVl_Locacao;
    property Ds_Formulacartao : String read fDs_Formulacartao write fDs_Formulacartao;
    property In_Convenio : String read fIn_Convenio write fIn_Convenio;
    property Nr_Diaconvenio : Real read fNr_Diaconvenio write fNr_Diaconvenio;
    property In_Fevereiro28 : String read fIn_Fevereiro28 write fIn_Fevereiro28;
    property Vl_Operacao : Real read fVl_Operacao write fVl_Operacao;
    property In_Predatado : String read fIn_Predatado write fIn_Predatado;
    property Nr_Diasmaxpre : Real read fNr_Diasmaxpre write fNr_Diasmaxpre;
  end;

  TFgr_FormulacartaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Formulacartao;
    procedure SetItem(Index: Integer; Value: TFgr_Formulacartao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Formulacartao;
    property Items[Index: Integer]: TFgr_Formulacartao read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Formulacartao }

constructor TFgr_Formulacartao.Create;
begin

end;

destructor TFgr_Formulacartao.Destroy;
begin

  inherited;
end;

{ TFgr_FormulacartaoList }

constructor TFgr_FormulacartaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Formulacartao);
end;

function TFgr_FormulacartaoList.Add: TFgr_Formulacartao;
begin
  Result := TFgr_Formulacartao(inherited Add);
  Result.create;
end;

function TFgr_FormulacartaoList.GetItem(Index: Integer): TFgr_Formulacartao;
begin
  Result := TFgr_Formulacartao(inherited GetItem(Index));
end;

procedure TFgr_FormulacartaoList.SetItem(Index: Integer; Value: TFgr_Formulacartao);
begin
  inherited SetItem(Index, Value);
end;

end.