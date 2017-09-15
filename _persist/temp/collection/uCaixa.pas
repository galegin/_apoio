unit uCaixa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCaixa = class;
  TCaixaClass = class of TCaixa;

  TCaixaList = class;
  TCaixaListClass = class of TCaixaList;

  TCaixa = class(TmCollectionItem)
  private
    fId_Caixa: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Terminal: Integer;
    fDt_Abertura: String;
    fVl_Abertura: String;
    fIn_Fechado: String;
    fDt_Fechado: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Caixa : Integer read fId_Caixa write SetId_Caixa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Terminal : Integer read fCd_Terminal write SetCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write SetDt_Abertura;
    property Vl_Abertura : String read fVl_Abertura write SetVl_Abertura;
    property In_Fechado : String read fIn_Fechado write SetIn_Fechado;
    property Dt_Fechado : String read fDt_Fechado write SetDt_Fechado;
  end;

  TCaixaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TCaixa;
    procedure SetItem(Index: Integer; Value: TCaixa);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TCaixa;
    property Items[Index: Integer]: TCaixa read GetItem write SetItem; default;
  end;

implementation

{ TCaixa }

constructor TCaixa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TCaixa.Destroy;
begin

  inherited;
end;

{ TCaixaList }

constructor TCaixaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TCaixa);
end;

function TCaixaList.Add: TCaixa;
begin
  Result := TCaixa(inherited Add);
  Result.create;
end;

function TCaixaList.GetItem(Index: Integer): TCaixa;
begin
  Result := TCaixa(inherited GetItem(Index));
end;

procedure TCaixaList.SetItem(Index: Integer; Value: TCaixa);
begin
  inherited SetItem(Index, Value);
end;

end.