unit uPrdValor;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Valor = class;
  TPrd_ValorClass = class of TPrd_Valor;

  TPrd_ValorList = class;
  TPrd_ValorListClass = class of TPrd_ValorList;

  TPrd_Valor = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Produto: Real;
    fTp_Valor: String;
    fCd_Valor: Real;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Produto: Real;
    fIn_Basemarkup: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : Real read fCd_Valor write fCd_Valor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Produto : Real read fVl_Produto write fVl_Produto;
    property In_Basemarkup : String read fIn_Basemarkup write fIn_Basemarkup;
  end;

  TPrd_ValorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Valor;
    procedure SetItem(Index: Integer; Value: TPrd_Valor);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Valor;
    property Items[Index: Integer]: TPrd_Valor read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Valor }

constructor TPrd_Valor.Create;
begin

end;

destructor TPrd_Valor.Destroy;
begin

  inherited;
end;

{ TPrd_ValorList }

constructor TPrd_ValorList.Create(AOwner: TPersistent);
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