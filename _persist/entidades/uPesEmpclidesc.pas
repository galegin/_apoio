unit uPesEmpclidesc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Empclidesc = class;
  TPes_EmpclidescClass = class of TPes_Empclidesc;

  TPes_EmpclidescList = class;
  TPes_EmpclidescListClass = class of TPes_EmpclidescList;

  TPes_Empclidesc = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Descmax: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Descmax : Real read fPr_Descmax write fPr_Descmax;
  end;

  TPes_EmpclidescList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Empclidesc;
    procedure SetItem(Index: Integer; Value: TPes_Empclidesc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Empclidesc;
    property Items[Index: Integer]: TPes_Empclidesc read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Empclidesc }

constructor TPes_Empclidesc.Create;
begin

end;

destructor TPes_Empclidesc.Destroy;
begin

  inherited;
end;

{ TPes_EmpclidescList }

constructor TPes_EmpclidescList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Empclidesc);
end;

function TPes_EmpclidescList.Add: TPes_Empclidesc;
begin
  Result := TPes_Empclidesc(inherited Add);
  Result.create;
end;

function TPes_EmpclidescList.GetItem(Index: Integer): TPes_Empclidesc;
begin
  Result := TPes_Empclidesc(inherited GetItem(Index));
end;

procedure TPes_EmpclidescList.SetItem(Index: Integer; Value: TPes_Empclidesc);
begin
  inherited SetItem(Index, Value);
end;

end.