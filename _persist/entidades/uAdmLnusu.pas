unit uAdmLnusu;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Lnusu = class;
  TAdm_LnusuClass = class of TAdm_Lnusu;

  TAdm_LnusuList = class;
  TAdm_LnusuListClass = class of TAdm_LnusuList;

  TAdm_Lnusu = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Todos: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Todos : String read fIn_Todos write fIn_Todos;
  end;

  TAdm_LnusuList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Lnusu;
    procedure SetItem(Index: Integer; Value: TAdm_Lnusu);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Lnusu;
    property Items[Index: Integer]: TAdm_Lnusu read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Lnusu }

constructor TAdm_Lnusu.Create;
begin

end;

destructor TAdm_Lnusu.Destroy;
begin

  inherited;
end;

{ TAdm_LnusuList }

constructor TAdm_LnusuList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Lnusu);
end;

function TAdm_LnusuList.Add: TAdm_Lnusu;
begin
  Result := TAdm_Lnusu(inherited Add);
  Result.create;
end;

function TAdm_LnusuList.GetItem(Index: Integer): TAdm_Lnusu;
begin
  Result := TAdm_Lnusu(inherited GetItem(Index));
end;

procedure TAdm_LnusuList.SetItem(Index: Integer; Value: TAdm_Lnusu);
begin
  inherited SetItem(Index, Value);
end;

end.