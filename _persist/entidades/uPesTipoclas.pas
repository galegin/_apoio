unit uPesTipoclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Tipoclas = class;
  TPes_TipoclasClass = class of TPes_Tipoclas;

  TPes_TipoclasList = class;
  TPes_TipoclasListClass = class of TPes_TipoclasList;

  TPes_Tipoclas = class(TcCollectionItem)
  private
    fCd_Tipoclas: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tipoclas: String;
    fIn_Pesmultclas: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipoclas : String read fDs_Tipoclas write fDs_Tipoclas;
    property In_Pesmultclas : String read fIn_Pesmultclas write fIn_Pesmultclas;
  end;

  TPes_TipoclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Tipoclas;
    procedure SetItem(Index: Integer; Value: TPes_Tipoclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Tipoclas;
    property Items[Index: Integer]: TPes_Tipoclas read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Tipoclas }

constructor TPes_Tipoclas.Create;
begin

end;

destructor TPes_Tipoclas.Destroy;
begin

  inherited;
end;

{ TPes_TipoclasList }

constructor TPes_TipoclasList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Tipoclas);
end;

function TPes_TipoclasList.Add: TPes_Tipoclas;
begin
  Result := TPes_Tipoclas(inherited Add);
  Result.create;
end;

function TPes_TipoclasList.GetItem(Index: Integer): TPes_Tipoclas;
begin
  Result := TPes_Tipoclas(inherited GetItem(Index));
end;

procedure TPes_TipoclasList.SetItem(Index: Integer; Value: TPes_Tipoclas);
begin
  inherited SetItem(Index, Value);
end;

end.