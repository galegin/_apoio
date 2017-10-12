unit uGerOpervalor;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Opervalor = class;
  TGer_OpervalorClass = class of TGer_Opervalor;

  TGer_OpervalorList = class;
  TGer_OpervalorListClass = class of TGer_OpervalorList;

  TGer_Opervalor = class(TmCollectionItem)
  private
    fCd_Operacao: String;
    fTp_Unidvalor: String;
    fCd_Unidvalor: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Precobase: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property Tp_Unidvalor : String read fTp_Unidvalor write SetTp_Unidvalor;
    property Cd_Unidvalor : String read fCd_Unidvalor write SetCd_Unidvalor;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Precobase : String read fIn_Precobase write SetIn_Precobase;
  end;

  TGer_OpervalorList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Opervalor;
    procedure SetItem(Index: Integer; Value: TGer_Opervalor);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Opervalor;
    property Items[Index: Integer]: TGer_Opervalor read GetItem write SetItem; default;
  end;

implementation

{ TGer_Opervalor }

constructor TGer_Opervalor.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Opervalor.Destroy;
begin

  inherited;
end;

{ TGer_OpervalorList }

constructor TGer_OpervalorList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Opervalor);
end;

function TGer_OpervalorList.Add: TGer_Opervalor;
begin
  Result := TGer_Opervalor(inherited Add);
  Result.create;
end;

function TGer_OpervalorList.GetItem(Index: Integer): TGer_Opervalor;
begin
  Result := TGer_Opervalor(inherited GetItem(Index));
end;

procedure TGer_OpervalorList.SetItem(Index: Integer; Value: TGer_Opervalor);
begin
  inherited SetItem(Index, Value);
end;

end.