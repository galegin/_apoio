unit uGerOperterm;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Operterm = class;
  TGer_OpertermClass = class of TGer_Operterm;

  TGer_OpertermList = class;
  TGer_OpertermListClass = class of TGer_OpertermList;

  TGer_Operterm = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Serie: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
  end;

  TGer_OpertermList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Operterm;
    procedure SetItem(Index: Integer; Value: TGer_Operterm);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Operterm;
    property Items[Index: Integer]: TGer_Operterm read GetItem write SetItem; default;
  end;

implementation

{ TGer_Operterm }

constructor TGer_Operterm.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Operterm.Destroy;
begin

  inherited;
end;

{ TGer_OpertermList }

constructor TGer_OpertermList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Operterm);
end;

function TGer_OpertermList.Add: TGer_Operterm;
begin
  Result := TGer_Operterm(inherited Add);
  Result.create;
end;

function TGer_OpertermList.GetItem(Index: Integer): TGer_Operterm;
begin
  Result := TGer_Operterm(inherited GetItem(Index));
end;

procedure TGer_OpertermList.SetItem(Index: Integer; Value: TGer_Operterm);
begin
  inherited SetItem(Index, Value);
end;

end.