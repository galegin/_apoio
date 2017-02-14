unit uFisDetalheicms;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Detalheicms = class;
  TFis_DetalheicmsClass = class of TFis_Detalheicms;

  TFis_DetalheicmsList = class;
  TFis_DetalheicmsListClass = class of TFis_DetalheicmsList;

  TFis_Detalheicms = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fDt_Mesano: TDateTime;
    fCd_Imposto: Real;
    fCd_Detalhamento: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Detalhe: Real;
    fNr_Inscrestadual: Real;
    fCd_Ocorrencia: Real;
    fDs_Descricao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Dt_Mesano : TDateTime read fDt_Mesano write fDt_Mesano;
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property Cd_Detalhamento : Real read fCd_Detalhamento write fCd_Detalhamento;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Detalhe : Real read fVl_Detalhe write fVl_Detalhe;
    property Nr_Inscrestadual : Real read fNr_Inscrestadual write fNr_Inscrestadual;
    property Cd_Ocorrencia : Real read fCd_Ocorrencia write fCd_Ocorrencia;
    property Ds_Descricao : String read fDs_Descricao write fDs_Descricao;
  end;

  TFis_DetalheicmsList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Detalheicms;
    procedure SetItem(Index: Integer; Value: TFis_Detalheicms);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Detalheicms;
    property Items[Index: Integer]: TFis_Detalheicms read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Detalheicms }

constructor TFis_Detalheicms.Create;
begin

end;

destructor TFis_Detalheicms.Destroy;
begin

  inherited;
end;

{ TFis_DetalheicmsList }

constructor TFis_DetalheicmsList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Detalheicms);
end;

function TFis_DetalheicmsList.Add: TFis_Detalheicms;
begin
  Result := TFis_Detalheicms(inherited Add);
  Result.create;
end;

function TFis_DetalheicmsList.GetItem(Index: Integer): TFis_Detalheicms;
begin
  Result := TFis_Detalheicms(inherited GetItem(Index));
end;

procedure TFis_DetalheicmsList.SetItem(Index: Integer; Value: TFis_Detalheicms);
begin
  inherited SetItem(Index, Value);
end;

end.