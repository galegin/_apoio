unit uPrdTipovalor;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Tipovalor = class;
  TPrd_TipovalorClass = class of TPrd_Tipovalor;

  TPrd_TipovalorList = class;
  TPrd_TipovalorListClass = class of TPrd_TipovalorList;

  TPrd_Tipovalor = class(TmCollectionItem)
  private
    fTp_Valor: String;
    fCd_Valor: String;
    fU_Version: String;
    fCd_Moeda: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Valor: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Tp_Valor : String read fTp_Valor write SetTp_Valor;
    property Cd_Valor : String read fCd_Valor write SetCd_Valor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Moeda : String read fCd_Moeda write SetCd_Moeda;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Valor : String read fDs_Valor write SetDs_Valor;
  end;

  TPrd_TipovalorList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Tipovalor;
    procedure SetItem(Index: Integer; Value: TPrd_Tipovalor);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Tipovalor;
    property Items[Index: Integer]: TPrd_Tipovalor read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Tipovalor }

constructor TPrd_Tipovalor.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Tipovalor.Destroy;
begin

  inherited;
end;

{ TPrd_TipovalorList }

constructor TPrd_TipovalorList.Create(AOwner: TPersistentCollection);
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