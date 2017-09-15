unit uRegrafiscal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TRegrafiscal = class;
  TRegrafiscalClass = class of TRegrafiscal;

  TRegrafiscalList = class;
  TRegrafiscalListClass = class of TRegrafiscalList;

  TRegrafiscal = class(TmCollectionItem)
  private
    fId_Regrafiscal: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Regrafiscal: String;
    fIn_Calcimposto: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Regrafiscal : Integer read fId_Regrafiscal write SetId_Regrafiscal;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Regrafiscal : String read fDs_Regrafiscal write SetDs_Regrafiscal;
    property In_Calcimposto : String read fIn_Calcimposto write SetIn_Calcimposto;
  end;

  TRegrafiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TRegrafiscal;
    procedure SetItem(Index: Integer; Value: TRegrafiscal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TRegrafiscal;
    property Items[Index: Integer]: TRegrafiscal read GetItem write SetItem; default;
  end;

implementation

{ TRegrafiscal }

constructor TRegrafiscal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TRegrafiscal.Destroy;
begin

  inherited;
end;

{ TRegrafiscalList }

constructor TRegrafiscalList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TRegrafiscal);
end;

function TRegrafiscalList.Add: TRegrafiscal;
begin
  Result := TRegrafiscal(inherited Add);
  Result.create;
end;

function TRegrafiscalList.GetItem(Index: Integer): TRegrafiscal;
begin
  Result := TRegrafiscal(inherited GetItem(Index));
end;

procedure TRegrafiscalList.SetItem(Index: Integer; Value: TRegrafiscal);
begin
  inherited SetItem(Index, Value);
end;

end.