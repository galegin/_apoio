unit uCfop;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TCfop = class(TmCollectionItem)
  private
    fCd_Cfop: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fDs_Cfop: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cfop : Integer read fCd_Cfop write fCd_Cfop;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Cfop : String read fDs_Cfop write fDs_Cfop;
  end;

  TCfops = class(TmCollection)
  private
    function GetItem(Index: Integer): TCfop;
    procedure SetItem(Index: Integer; Value: TCfop);
  public
    constructor Create(AItemClass: TCollectionItemClass); override;
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

{ TCfops }

constructor TCfops.Create(AItemClass: TCollectionItemClass);
begin
  inherited Create(TCfop);
end;

function TCfops.Add: TCfop;
begin
  Result := TCfop(inherited Add);
end;

function TCfops.GetItem(Index: Integer): TCfop;
begin
  Result := TCfop(inherited GetItem(Index));
end;

procedure TCfops.SetItem(Index: Integer; Value: TCfop);
begin
  inherited SetItem(Index, Value);
end;

end.