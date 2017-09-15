unit uNcm;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TNcm = class;
  TNcmClass = class of TNcm;

  TNcmList = class;
  TNcmListClass = class of TNcmList;

  TNcm = class(TmCollectionItem)
  private
    fCd_Ncm: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fDs_Ncm: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Ncm : String read fCd_Ncm write SetCd_Ncm;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Ncm : String read fDs_Ncm write SetDs_Ncm;
  end;

  TNcmList = class(TmCollection)
  private
    function GetItem(Index: Integer): TNcm;
    procedure SetItem(Index: Integer; Value: TNcm);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TNcm;
    property Items[Index: Integer]: TNcm read GetItem write SetItem; default;
  end;

implementation

{ TNcm }

constructor TNcm.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TNcm.Destroy;
begin

  inherited;
end;

{ TNcmList }

constructor TNcmList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TNcm);
end;

function TNcmList.Add: TNcm;
begin
  Result := TNcm(inherited Add);
  Result.create;
end;

function TNcmList.GetItem(Index: Integer): TNcm;
begin
  Result := TNcm(inherited GetItem(Index));
end;

procedure TNcmList.SetItem(Index: Integer; Value: TNcm);
begin
  inherited SetItem(Index, Value);
end;

end.