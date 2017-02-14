unit uPrdPrdsaldo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdsaldo = class;
  TPrd_PrdsaldoClass = class of TPrd_Prdsaldo;

  TPrd_PrdsaldoList = class;
  TPrd_PrdsaldoListClass = class of TPrd_PrdsaldoList;

  TPrd_Prdsaldo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Produto: Real;
    fCd_Saldo: Real;
    fDt_Saldo: TDateTime;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fQt_Saldo: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Saldo : Real read fCd_Saldo write fCd_Saldo;
    property Dt_Saldo : TDateTime read fDt_Saldo write fDt_Saldo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Qt_Saldo : Real read fQt_Saldo write fQt_Saldo;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_PrdsaldoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdsaldo;
    procedure SetItem(Index: Integer; Value: TPrd_Prdsaldo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdsaldo;
    property Items[Index: Integer]: TPrd_Prdsaldo read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdsaldo }

constructor TPrd_Prdsaldo.Create;
begin

end;

destructor TPrd_Prdsaldo.Destroy;
begin

  inherited;
end;

{ TPrd_PrdsaldoList }

constructor TPrd_PrdsaldoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Prdsaldo);
end;

function TPrd_PrdsaldoList.Add: TPrd_Prdsaldo;
begin
  Result := TPrd_Prdsaldo(inherited Add);
  Result.create;
end;

function TPrd_PrdsaldoList.GetItem(Index: Integer): TPrd_Prdsaldo;
begin
  Result := TPrd_Prdsaldo(inherited GetItem(Index));
end;

procedure TPrd_PrdsaldoList.SetItem(Index: Integer; Value: TPrd_Prdsaldo);
begin
  inherited SetItem(Index, Value);
end;

end.