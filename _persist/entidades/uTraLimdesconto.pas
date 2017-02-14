unit uTraLimdesconto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Limdesconto = class;
  TTra_LimdescontoClass = class of TTra_Limdesconto;

  TTra_LimdescontoList = class;
  TTra_LimdescontoListClass = class of TTra_LimdescontoList;

  TTra_Limdesconto = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fCd_Usuario: Real;
    fU_Version: String;
    fPr_Descmax: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Descmax : Real read fPr_Descmax write fPr_Descmax;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_LimdescontoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Limdesconto;
    procedure SetItem(Index: Integer; Value: TTra_Limdesconto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Limdesconto;
    property Items[Index: Integer]: TTra_Limdesconto read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Limdesconto }

constructor TTra_Limdesconto.Create;
begin

end;

destructor TTra_Limdesconto.Destroy;
begin

  inherited;
end;

{ TTra_LimdescontoList }

constructor TTra_LimdescontoList.Create(AOwner: TPersistent);
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