unit uFisCfop;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Cfop = class;
  TFis_CfopClass = class of TFis_Cfop;

  TFis_CfopList = class;
  TFis_CfopListClass = class of TFis_CfopList;

  TFis_Cfop = class(TcCollectionItem)
  private
    fTp_Operacao: String;
    fTp_Contribuinte: String;
    fTp_Transacao: Real;
    fTp_Producao: String;
    fTp_Comercial: String;
    fTp_Modalidade: String;
    fTp_Regimesub: String;
    fTp_Finalcompra: String;
    fU_Version: String;
    fCd_Cfop: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Cfop: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Tp_Contribuinte : String read fTp_Contribuinte write fTp_Contribuinte;
    property Tp_Transacao : Real read fTp_Transacao write fTp_Transacao;
    property Tp_Producao : String read fTp_Producao write fTp_Producao;
    property Tp_Comercial : String read fTp_Comercial write fTp_Comercial;
    property Tp_Modalidade : String read fTp_Modalidade write fTp_Modalidade;
    property Tp_Regimesub : String read fTp_Regimesub write fTp_Regimesub;
    property Tp_Finalcompra : String read fTp_Finalcompra write fTp_Finalcompra;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write fDs_Cfop;
  end;

  TFis_CfopList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Cfop;
    procedure SetItem(Index: Integer; Value: TFis_Cfop);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Cfop;
    property Items[Index: Integer]: TFis_Cfop read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Cfop }

constructor TFis_Cfop.Create;
begin

end;

destructor TFis_Cfop.Destroy;
begin

  inherited;
end;

{ TFis_CfopList }

constructor TFis_CfopList.Create(AOwner: TPersistent);
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