unit uPesEmpclidesc;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Empclidesc = class;
  TPes_EmpclidescClass = class of TPes_Empclidesc;

  TPes_EmpclidescList = class;
  TPes_EmpclidescListClass = class of TPes_EmpclidescList;

  TPes_Empclidesc = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Cliente: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Descmax: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Cliente : String read fCd_Cliente write SetCd_Cliente;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Descmax : String read fPr_Descmax write SetPr_Descmax;
  end;

  TPes_EmpclidescList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Empclidesc;
    procedure SetItem(Index: Integer; Value: TPes_Empclidesc);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Empclidesc;
    property Items[Index: Integer]: TPes_Empclidesc read GetItem write SetItem; default;
  end;

implementation

{ TPes_Empclidesc }

constructor TPes_Empclidesc.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Empclidesc.Destroy;
begin

  inherited;
end;

{ TPes_EmpclidescList }

constructor TPes_EmpclidescList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Empclidesc);
end;

function TPes_EmpclidescList.Add: TPes_Empclidesc;
begin
  Result := TPes_Empclidesc(inherited Add);
  Result.create;
end;

function TPes_EmpclidescList.GetItem(Index: Integer): TPes_Empclidesc;
begin
  Result := TPes_Empclidesc(inherited GetItem(Index));
end;

procedure TPes_EmpclidescList.SetItem(Index: Integer; Value: TPes_Empclidesc);
begin
  inherited SetItem(Index, Value);
end;

end.