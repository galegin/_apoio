unit uTraLimdesconto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Limdesconto = class;
  TTra_LimdescontoClass = class of TTra_Limdesconto;

  TTra_LimdescontoList = class;
  TTra_LimdescontoListClass = class of TTra_LimdescontoList;

  TTra_Limdesconto = class(TmCollectionItem)
  private
    fCd_Operacao: String;
    fCd_Usuario: String;
    fU_Version: String;
    fPr_Descmax: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property Cd_Usuario : String read fCd_Usuario write SetCd_Usuario;
    property U_Version : String read fU_Version write SetU_Version;
    property Pr_Descmax : String read fPr_Descmax write SetPr_Descmax;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TTra_LimdescontoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Limdesconto;
    procedure SetItem(Index: Integer; Value: TTra_Limdesconto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Limdesconto;
    property Items[Index: Integer]: TTra_Limdesconto read GetItem write SetItem; default;
  end;

implementation

{ TTra_Limdesconto }

constructor TTra_Limdesconto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Limdesconto.Destroy;
begin

  inherited;
end;

{ TTra_LimdescontoList }

constructor TTra_LimdescontoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TTra_Limdesconto);
end;

function TTra_LimdescontoList.Add: TTra_Limdesconto;
begin
  Result := TTra_Limdesconto(inherited Add);
  Result.create;
end;

function TTra_LimdescontoList.GetItem(Index: Integer): TTra_Limdesconto;
begin
  Result := TTra_Limdesconto(inherited GetItem(Index));
end;

procedure TTra_LimdescontoList.SetItem(Index: Integer; Value: TTra_Limdesconto);
begin
  inherited SetItem(Index, Value);
end;

end.