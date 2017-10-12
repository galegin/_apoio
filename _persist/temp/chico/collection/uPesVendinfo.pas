unit uPesVendinfo;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Vendinfo = class;
  TPes_VendinfoClass = class of TPes_Vendinfo;

  TPes_VendinfoList = class;
  TPes_VendinfoListClass = class of TPes_VendinfoList;

  TPes_Vendinfo = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Vendedor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Auxiliar: String;
    fIn_Inativo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Vendedor : String read fCd_Vendedor write SetCd_Vendedor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Auxiliar : String read fCd_Auxiliar write SetCd_Auxiliar;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
  end;

  TPes_VendinfoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Vendinfo;
    procedure SetItem(Index: Integer; Value: TPes_Vendinfo);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Vendinfo;
    property Items[Index: Integer]: TPes_Vendinfo read GetItem write SetItem; default;
  end;

implementation

{ TPes_Vendinfo }

constructor TPes_Vendinfo.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Vendinfo.Destroy;
begin

  inherited;
end;

{ TPes_VendinfoList }

constructor TPes_VendinfoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Vendinfo);
end;

function TPes_VendinfoList.Add: TPes_Vendinfo;
begin
  Result := TPes_Vendinfo(inherited Add);
  Result.create;
end;

function TPes_VendinfoList.GetItem(Index: Integer): TPes_Vendinfo;
begin
  Result := TPes_Vendinfo(inherited GetItem(Index));
end;

procedure TPes_VendinfoList.SetItem(Index: Integer; Value: TPes_Vendinfo);
begin
  inherited SetItem(Index, Value);
end;

end.