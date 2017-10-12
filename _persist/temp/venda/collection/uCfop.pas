unit uCfop;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCfop = class;
  TCfopClass = class of TCfop;

  TCfopList = class;
  TCfopListClass = class of TCfopList;

  TCfop = class(TmCollectionItem)
  private
    fCd_Cfop: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Cfop: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cfop : Integer read fCd_Cfop write SetCd_Cfop;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write SetDs_Cfop;
  end;

  TCfopList = class(TmCollection)
  private
    function GetItem(Index: Integer): TCfop;
    procedure SetItem(Index: Integer; Value: TCfop);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TCfop;
    property Items[Index: Integer]: TCfop read GetItem write SetItem; default;
  end;

implementation

{ TCfop }

constructor TCfop.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TCfop.Destroy;
begin

  inherited;
end;

{ TCfopList }

constructor TCfopList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TCfop);
end;

function TCfopList.Add: TCfop;
begin
  Result := TCfop(inherited Add);
  Result.create;
end;

function TCfopList.GetItem(Index: Integer): TCfop;
begin
  Result := TCfop(inherited GetItem(Index));
end;

procedure TCfopList.SetItem(Index: Integer; Value: TCfop);
begin
  inherited SetItem(Index, Value);
end;

end.