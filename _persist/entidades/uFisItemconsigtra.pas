unit uFisItemconsigtra;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Itemconsigtra = class;
  TFis_ItemconsigtraClass = class of TFis_Itemconsigtra;

  TFis_ItemconsigtraList = class;
  TFis_ItemconsigtraListClass = class of TFis_ItemconsigtraList;

  TFis_Itemconsigtra = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fCd_Produto: Real;
    fCd_Emptra: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Emptra : Real read fCd_Emptra write fCd_Emptra;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_ItemconsigtraList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Itemconsigtra;
    procedure SetItem(Index: Integer; Value: TFis_Itemconsigtra);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Itemconsigtra;
    property Items[Index: Integer]: TFis_Itemconsigtra read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Itemconsigtra }

constructor TFis_Itemconsigtra.Create;
begin

end;

destructor TFis_Itemconsigtra.Destroy;
begin

  inherited;
end;

{ TFis_ItemconsigtraList }

constructor TFis_ItemconsigtraList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Itemconsigtra);
end;

function TFis_ItemconsigtraList.Add: TFis_Itemconsigtra;
begin
  Result := TFis_Itemconsigtra(inherited Add);
  Result.create;
end;

function TFis_ItemconsigtraList.GetItem(Index: Integer): TFis_Itemconsigtra;
begin
  Result := TFis_Itemconsigtra(inherited GetItem(Index));
end;

procedure TFis_ItemconsigtraList.SetItem(Index: Integer; Value: TFis_Itemconsigtra);
begin
  inherited SetItem(Index, Value);
end;

end.