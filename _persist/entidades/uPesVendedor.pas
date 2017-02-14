unit uPesVendedor;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Vendedor = class;
  TPes_VendedorClass = class of TPes_Vendedor;

  TPes_VendedorList = class;
  TPes_VendedorListClass = class of TPes_VendedorList;

  TPes_Vendedor = class(TcCollectionItem)
  private
    fCd_Vendedor: Real;
    fU_Version: String;
    fCd_Pessoa: Real;
    fNm_Vendedor: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Vendedor : Real read fCd_Vendedor write fCd_Vendedor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nm_Vendedor : String read fNm_Vendedor write fNm_Vendedor;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_VendedorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Vendedor;
    procedure SetItem(Index: Integer; Value: TPes_Vendedor);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Vendedor;
    property Items[Index: Integer]: TPes_Vendedor read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Vendedor }

constructor TPes_Vendedor.Create;
begin

end;

destructor TPes_Vendedor.Destroy;
begin

  inherited;
end;

{ TPes_VendedorList }

constructor TPes_VendedorList.Create(AOwner: TPersistent);
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