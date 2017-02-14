unit uPrdComposicaoc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Composicaoc = class;
  TPrd_ComposicaocClass = class of TPrd_Composicaoc;

  TPrd_ComposicaocList = class;
  TPrd_ComposicaocListClass = class of TPrd_ComposicaocList;

  TPrd_Composicaoc = class(TcCollectionItem)
  private
    fCd_Composicao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Composicao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Composicao : Real read fCd_Composicao write fCd_Composicao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Composicao : String read fDs_Composicao write fDs_Composicao;
  end;

  TPrd_ComposicaocList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Composicaoc;
    procedure SetItem(Index: Integer; Value: TPrd_Composicaoc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Composicaoc;
    property Items[Index: Integer]: TPrd_Composicaoc read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Composicaoc }

constructor TPrd_Composicaoc.Create;
begin

end;

destructor TPrd_Composicaoc.Destroy;
begin

  inherited;
end;

{ TPrd_ComposicaocList }

constructor TPrd_ComposicaocList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Composicaoc);
end;

function TPrd_ComposicaocList.Add: TPrd_Composicaoc;
begin
  Result := TPrd_Composicaoc(inherited Add);
  Result.create;
end;

function TPrd_ComposicaocList.GetItem(Index: Integer): TPrd_Composicaoc;
begin
  Result := TPrd_Composicaoc(inherited GetItem(Index));
end;

procedure TPrd_ComposicaocList.SetItem(Index: Integer; Value: TPrd_Composicaoc);
begin
  inherited SetItem(Index, Value);
end;

end.