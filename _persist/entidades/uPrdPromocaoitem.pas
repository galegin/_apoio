unit uPrdPromocaoitem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Promocaoitem = class;
  TPrd_PromocaoitemClass = class of TPrd_Promocaoitem;

  TPrd_PromocaoitemList = class;
  TPrd_PromocaoitemListClass = class of TPrd_PromocaoitemList;

  TPrd_Promocaoitem = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Promocao: Real;
    fCd_Produto: Real;
    fU_Version: String;
    fVl_Anterior: Real;
    fVl_Promocao: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fQt_Promovida: Real;
    fQt_Vendida: Real;
    fTp_Situacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Promocao : Real read fCd_Promocao write fCd_Promocao;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Vl_Anterior : Real read fVl_Anterior write fVl_Anterior;
    property Vl_Promocao : Real read fVl_Promocao write fVl_Promocao;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Qt_Promovida : Real read fQt_Promovida write fQt_Promovida;
    property Qt_Vendida : Real read fQt_Vendida write fQt_Vendida;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
  end;

  TPrd_PromocaoitemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Promocaoitem;
    procedure SetItem(Index: Integer; Value: TPrd_Promocaoitem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Promocaoitem;
    property Items[Index: Integer]: TPrd_Promocaoitem read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Promocaoitem }

constructor TPrd_Promocaoitem.Create;
begin

end;

destructor TPrd_Promocaoitem.Destroy;
begin

  inherited;
end;

{ TPrd_PromocaoitemList }

constructor TPrd_PromocaoitemList.Create(AOwner: TPersistent);
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