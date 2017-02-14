unit uPrdTipovalor;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Tipovalor = class;
  TPrd_TipovalorClass = class of TPrd_Tipovalor;

  TPrd_TipovalorList = class;
  TPrd_TipovalorListClass = class of TPrd_TipovalorList;

  TPrd_Tipovalor = class(TcCollectionItem)
  private
    fTp_Valor: String;
    fCd_Valor: Real;
    fU_Version: String;
    fCd_Moeda: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Valor: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : Real read fCd_Valor write fCd_Valor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Moeda : Real read fCd_Moeda write fCd_Moeda;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Valor : String read fDs_Valor write fDs_Valor;
  end;

  TPrd_TipovalorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Tipovalor;
    procedure SetItem(Index: Integer; Value: TPrd_Tipovalor);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Tipovalor;
    property Items[Index: Integer]: TPrd_Tipovalor read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Tipovalor }

constructor TPrd_Tipovalor.Create;
begin

end;

destructor TPrd_Tipovalor.Destroy;
begin

  inherited;
end;

{ TPrd_TipovalorList }

constructor TPrd_TipovalorList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Tipovalor);
end;

function TPrd_TipovalorList.Add: TPrd_Tipovalor;
begin
  Result := TPrd_Tipovalor(inherited Add);
  Result.create;
end;

function TPrd_TipovalorList.GetItem(Index: Integer): TPrd_Tipovalor;
begin
  Result := TPrd_Tipovalor(inherited GetItem(Index));
end;

procedure TPrd_TipovalorList.SetItem(Index: Integer; Value: TPrd_Tipovalor);
begin
  inherited SetItem(Index, Value);
end;

end.