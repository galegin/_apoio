unit uGerTipoclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Tipoclas = class;
  TGer_TipoclasClass = class of TGer_Tipoclas;

  TGer_TipoclasList = class;
  TGer_TipoclasListClass = class of TGer_TipoclasList;

  TGer_Tipoclas = class(TcCollectionItem)
  private
    fCd_Tipoclas: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tipoclas: String;
    fTp_Tipoclas: Real;
    fIn_Multiclas: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipoclas : String read fDs_Tipoclas write fDs_Tipoclas;
    property Tp_Tipoclas : Real read fTp_Tipoclas write fTp_Tipoclas;
    property In_Multiclas : String read fIn_Multiclas write fIn_Multiclas;
  end;

  TGer_TipoclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Tipoclas;
    procedure SetItem(Index: Integer; Value: TGer_Tipoclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Tipoclas;
    property Items[Index: Integer]: TGer_Tipoclas read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Tipoclas }

constructor TGer_Tipoclas.Create;
begin

end;

destructor TGer_Tipoclas.Destroy;
begin

  inherited;
end;

{ TGer_TipoclasList }

constructor TGer_TipoclasList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Tipoclas);
end;

function TGer_TipoclasList.Add: TGer_Tipoclas;
begin
  Result := TGer_Tipoclas(inherited Add);
  Result.create;
end;

function TGer_TipoclasList.GetItem(Index: Integer): TGer_Tipoclas;
begin
  Result := TGer_Tipoclas(inherited GetItem(Index));
end;

procedure TGer_TipoclasList.SetItem(Index: Integer; Value: TGer_Tipoclas);
begin
  inherited SetItem(Index, Value);
end;

end.