unit uPrdValor;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Valor = class;
  TPrd_ValorClass = class of TPrd_Valor;

  TPrd_ValorList = class;
  TPrd_ValorListClass = class of TPrd_ValorList;

  TPrd_Valor = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Produto: String;
    fTp_Valor: String;
    fCd_Valor: String;
    fU_Version: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fVl_Produto: String;
    fIn_Basemarkup: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Tp_Valor : String read fTp_Valor write SetTp_Valor;
    property Cd_Valor : String read fCd_Valor write SetCd_Valor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Vl_Produto : String read fVl_Produto write SetVl_Produto;
    property In_Basemarkup : String read fIn_Basemarkup write SetIn_Basemarkup;
  end;

  TPrd_ValorList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Valor;
    procedure SetItem(Index: Integer; Value: TPrd_Valor);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Valor;
    property Items[Index: Integer]: TPrd_Valor read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Valor }

constructor TPrd_Valor.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Valor.Destroy;
begin

  inherited;
end;

{ TPrd_ValorList }

constructor TPrd_ValorList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Valor);
end;

function TPrd_ValorList.Add: TPrd_Valor;
begin
  Result := TPrd_Valor(inherited Add);
  Result.create;
end;

function TPrd_ValorList.GetItem(Index: Integer): TPrd_Valor;
begin
  Result := TPrd_Valor(inherited GetItem(Index));
end;

procedure TPrd_ValorList.SetItem(Index: Integer; Value: TPrd_Valor);
begin
  inherited SetItem(Index, Value);
end;

end.