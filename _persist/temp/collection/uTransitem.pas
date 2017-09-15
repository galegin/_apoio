unit uTransitem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTransitem = class;
  TTransitemClass = class of TTransitem;

  TTransitemList = class;
  TTransitemListClass = class of TTransitemList;

  TTransitem = class(TmCollectionItem)
  private
    fId_Transacao: String;
    fNr_Item: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fId_Produto: String;
    fCd_Produto: Integer;
    fDs_Produto: String;
    fCd_Cfop: Integer;
    fCd_Especie: String;
    fCd_Ncm: String;
    fQt_Item: String;
    fVl_Custo: String;
    fVl_Unitario: String;
    fVl_Item: String;
    fVl_Variacao: String;
    fVl_Variacaocapa: String;
    fVl_Frete: String;
    fVl_Seguro: String;
    fVl_Outro: String;
    fVl_Despesa: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Transacao : String read fId_Transacao write SetId_Transacao;
    property Nr_Item : Integer read fNr_Item write SetNr_Item;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Id_Produto : String read fId_Produto write SetId_Produto;
    property Cd_Produto : Integer read fCd_Produto write SetCd_Produto;
    property Ds_Produto : String read fDs_Produto write SetDs_Produto;
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property Cd_Especie : String read fCd_Especie write SetCd_Especie;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property Qt_Item : String read fQt_Item write SetQt_Item;
    property Vl_Custo : String read fVl_Custo write SetVl_Custo;
    property Vl_Unitario : String read fVl_Unitario write SetVl_Unitario;
    property Vl_Item : String read fVl_Item write SetVl_Item;
    property Vl_Variacao : String read fVl_Variacao write SetVl_Variacao;
    property Vl_Variacaocapa : String read fVl_Variacaocapa write SetVl_Variacaocapa;
    property Vl_Frete : String read fVl_Frete write SetVl_Frete;
    property Vl_Seguro : String read fVl_Seguro write SetVl_Seguro;
    property Vl_Outro : String read fVl_Outro write SetVl_Outro;
    property Vl_Despesa : String read fVl_Despesa write SetVl_Despesa;
  end;

  TTransitemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTransitem;
    procedure SetItem(Index: Integer; Value: TTransitem);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTransitem;
    property Items[Index: Integer]: TTransitem read GetItem write SetItem; default;
  end;

implementation

{ TTransitem }

constructor TTransitem.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTransitem.Destroy;
begin

  inherited;
end;

{ TTransitemList }

constructor TTransitemList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTransitem);
end;

function TTransitemList.Add: TTransitem;
begin
  Result := TTransitem(inherited Add);
  Result.create;
end;

function TTransitemList.GetItem(Index: Integer): TTransitem;
begin
  Result := TTransitem(inherited GetItem(Index));
end;

procedure TTransitemList.SetItem(Index: Integer; Value: TTransitem);
begin
  inherited SetItem(Index, Value);
end;

end.