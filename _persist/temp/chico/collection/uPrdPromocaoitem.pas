unit uPrdPromocaoitem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Promocaoitem = class;
  TPrd_PromocaoitemClass = class of TPrd_Promocaoitem;

  TPrd_PromocaoitemList = class;
  TPrd_PromocaoitemListClass = class of TPrd_PromocaoitemList;

  TPrd_Promocaoitem = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Promocao: String;
    fCd_Produto: String;
    fU_Version: String;
    fVl_Anterior: String;
    fVl_Promocao: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fQt_Promovida: String;
    fQt_Vendida: String;
    fTp_Situacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Promocao : String read fCd_Promocao write SetCd_Promocao;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property U_Version : String read fU_Version write SetU_Version;
    property Vl_Anterior : String read fVl_Anterior write SetVl_Anterior;
    property Vl_Promocao : String read fVl_Promocao write SetVl_Promocao;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Qt_Promovida : String read fQt_Promovida write SetQt_Promovida;
    property Qt_Vendida : String read fQt_Vendida write SetQt_Vendida;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
  end;

  TPrd_PromocaoitemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Promocaoitem;
    procedure SetItem(Index: Integer; Value: TPrd_Promocaoitem);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Promocaoitem;
    property Items[Index: Integer]: TPrd_Promocaoitem read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Promocaoitem }

constructor TPrd_Promocaoitem.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Promocaoitem.Destroy;
begin

  inherited;
end;

{ TPrd_PromocaoitemList }

constructor TPrd_PromocaoitemList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Promocaoitem);
end;

function TPrd_PromocaoitemList.Add: TPrd_Promocaoitem;
begin
  Result := TPrd_Promocaoitem(inherited Add);
  Result.create;
end;

function TPrd_PromocaoitemList.GetItem(Index: Integer): TPrd_Promocaoitem;
begin
  Result := TPrd_Promocaoitem(inherited GetItem(Index));
end;

procedure TPrd_PromocaoitemList.SetItem(Index: Integer; Value: TPrd_Promocaoitem);
begin
  inherited SetItem(Index, Value);
end;

end.