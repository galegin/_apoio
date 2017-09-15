unit uNcmsubst;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TNcmsubst = class;
  TNcmsubstClass = class of TNcmsubst;

  TNcmsubstList = class;
  TNcmsubstListClass = class of TNcmsubstList;

  TNcmsubst = class(TmCollectionItem)
  private
    fUf_Origem: String;
    fUf_Destino: String;
    fCd_Ncm: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fCd_Cest: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Uf_Origem : String read fUf_Origem write SetUf_Origem;
    property Uf_Destino : String read fUf_Destino write SetUf_Destino;
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Cest : String read fCd_Cest write SetCd_Cest;
  end;

  TNcmsubstList = class(TmCollection)
  private
    function GetItem(Index: Integer): TNcmsubst;
    procedure SetItem(Index: Integer; Value: TNcmsubst);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TNcmsubst;
    property Items[Index: Integer]: TNcmsubst read GetItem write SetItem; default;
  end;

implementation

{ TNcmsubst }

constructor TNcmsubst.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TNcmsubst.Destroy;
begin

  inherited;
end;

{ TNcmsubstList }

constructor TNcmsubstList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TNcmsubst);
end;

function TNcmsubstList.Add: TNcmsubst;
begin
  Result := TNcmsubst(inherited Add);
  Result.create;
end;

function TNcmsubstList.GetItem(Index: Integer): TNcmsubst;
begin
  Result := TNcmsubst(inherited GetItem(Index));
end;

procedure TNcmsubstList.SetItem(Index: Integer; Value: TNcmsubst);
begin
  inherited SetItem(Index, Value);
end;

end.