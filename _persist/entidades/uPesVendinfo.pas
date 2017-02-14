unit uPesVendinfo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Vendinfo = class;
  TPes_VendinfoClass = class of TPes_Vendinfo;

  TPes_VendinfoList = class;
  TPes_VendinfoListClass = class of TPes_VendinfoList;

  TPes_Vendinfo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Vendedor: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Auxiliar: Real;
    fIn_Inativo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Vendedor : Real read fCd_Vendedor write fCd_Vendedor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Auxiliar : Real read fCd_Auxiliar write fCd_Auxiliar;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
  end;

  TPes_VendinfoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Vendinfo;
    procedure SetItem(Index: Integer; Value: TPes_Vendinfo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Vendinfo;
    property Items[Index: Integer]: TPes_Vendinfo read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Vendinfo }

constructor TPes_Vendinfo.Create;
begin

end;

destructor TPes_Vendinfo.Destroy;
begin

  inherited;
end;

{ TPes_VendinfoList }

constructor TPes_VendinfoList.Create(AOwner: TPersistent);
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