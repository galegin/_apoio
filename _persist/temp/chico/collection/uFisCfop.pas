unit uFisCfop;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Cfop = class;
  TFis_CfopClass = class of TFis_Cfop;

  TFis_CfopList = class;
  TFis_CfopListClass = class of TFis_CfopList;

  TFis_Cfop = class(TmCollectionItem)
  private
    fTp_Operacao: String;
    fTp_Contribuinte: String;
    fTp_Transacao: String;
    fTp_Producao: String;
    fTp_Comercial: String;
    fTp_Modalidade: String;
    fTp_Regimesub: String;
    fTp_Finalcompra: String;
    fU_Version: String;
    fCd_Cfop: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Cfop: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Tp_Operacao : String read fTp_Operacao write SetTp_Operacao;
    property Tp_Contribuinte : String read fTp_Contribuinte write SetTp_Contribuinte;
    property Tp_Transacao : String read fTp_Transacao write SetTp_Transacao;
    property Tp_Producao : String read fTp_Producao write SetTp_Producao;
    property Tp_Comercial : String read fTp_Comercial write SetTp_Comercial;
    property Tp_Modalidade : String read fTp_Modalidade write SetTp_Modalidade;
    property Tp_Regimesub : String read fTp_Regimesub write SetTp_Regimesub;
    property Tp_Finalcompra : String read fTp_Finalcompra write SetTp_Finalcompra;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Cfop : String read fCd_Cfop write SetCd_Cfop;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write SetDs_Cfop;
  end;

  TFis_CfopList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Cfop;
    procedure SetItem(Index: Integer; Value: TFis_Cfop);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Cfop;
    property Items[Index: Integer]: TFis_Cfop read GetItem write SetItem; default;
  end;

implementation

{ TFis_Cfop }

constructor TFis_Cfop.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Cfop.Destroy;
begin

  inherited;
end;

{ TFis_CfopList }

constructor TFis_CfopList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Cfop);
end;

function TFis_CfopList.Add: TFis_Cfop;
begin
  Result := TFis_Cfop(inherited Add);
  Result.create;
end;

function TFis_CfopList.GetItem(Index: Integer): TFis_Cfop;
begin
  Result := TFis_Cfop(inherited GetItem(Index));
end;

procedure TFis_CfopList.SetItem(Index: Integer; Value: TFis_Cfop);
begin
  inherited SetItem(Index, Value);
end;

end.