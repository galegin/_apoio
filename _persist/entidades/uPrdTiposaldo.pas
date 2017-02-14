unit uPrdTiposaldo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Tiposaldo = class;
  TPrd_TiposaldoClass = class of TPrd_Tiposaldo;

  TPrd_TiposaldoList = class;
  TPrd_TiposaldoListClass = class of TPrd_TiposaldoList;

  TPrd_Tiposaldo = class(TcCollectionItem)
  private
    fCd_Saldo: Real;
    fU_Version: String;
    fTp_Disponivel: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Saldo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Saldo : Real read fCd_Saldo write fCd_Saldo;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Disponivel : String read fTp_Disponivel write fTp_Disponivel;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Saldo : String read fDs_Saldo write fDs_Saldo;
  end;

  TPrd_TiposaldoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Tiposaldo;
    procedure SetItem(Index: Integer; Value: TPrd_Tiposaldo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Tiposaldo;
    property Items[Index: Integer]: TPrd_Tiposaldo read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Tiposaldo }

constructor TPrd_Tiposaldo.Create;
begin

end;

destructor TPrd_Tiposaldo.Destroy;
begin

  inherited;
end;

{ TPrd_TiposaldoList }

constructor TPrd_TiposaldoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Tiposaldo);
end;

function TPrd_TiposaldoList.Add: TPrd_Tiposaldo;
begin
  Result := TPrd_Tiposaldo(inherited Add);
  Result.create;
end;

function TPrd_TiposaldoList.GetItem(Index: Integer): TPrd_Tiposaldo;
begin
  Result := TPrd_Tiposaldo(inherited GetItem(Index));
end;

procedure TPrd_TiposaldoList.SetItem(Index: Integer; Value: TPrd_Tiposaldo);
begin
  inherited SetItem(Index, Value);
end;

end.