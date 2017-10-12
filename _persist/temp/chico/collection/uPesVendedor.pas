unit uPesVendedor;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Vendedor = class;
  TPes_VendedorClass = class of TPes_Vendedor;

  TPes_VendedorList = class;
  TPes_VendedorListClass = class of TPes_VendedorList;

  TPes_Vendedor = class(TmCollectionItem)
  private
    fCd_Vendedor: String;
    fU_Version: String;
    fCd_Pessoa: String;
    fNm_Vendedor: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Vendedor : String read fCd_Vendedor write SetCd_Vendedor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nm_Vendedor : String read fNm_Vendedor write SetNm_Vendedor;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TPes_VendedorList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Vendedor;
    procedure SetItem(Index: Integer; Value: TPes_Vendedor);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Vendedor;
    property Items[Index: Integer]: TPes_Vendedor read GetItem write SetItem; default;
  end;

implementation

{ TPes_Vendedor }

constructor TPes_Vendedor.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Vendedor.Destroy;
begin

  inherited;
end;

{ TPes_VendedorList }

constructor TPes_VendedorList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Vendedor);
end;

function TPes_VendedorList.Add: TPes_Vendedor;
begin
  Result := TPes_Vendedor(inherited Add);
  Result.create;
end;

function TPes_VendedorList.GetItem(Index: Integer): TPes_Vendedor;
begin
  Result := TPes_Vendedor(inherited GetItem(Index));
end;

procedure TPes_VendedorList.SetItem(Index: Integer; Value: TPes_Vendedor);
begin
  inherited SetItem(Index, Value);
end;

end.