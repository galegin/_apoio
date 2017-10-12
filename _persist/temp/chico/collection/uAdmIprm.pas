unit uAdmIprm;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TAdm_Iprm = class;
  TAdm_IprmClass = class of TAdm_Iprm;

  TAdm_IprmList = class;
  TAdm_IprmListClass = class of TAdm_IprmList;

  TAdm_Iprm = class(TmCollectionItem)
  private
    fCd_Parametro: String;
    fU_Version: String;
    fVl_Parametro: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Parametro : String read fCd_Parametro write SetCd_Parametro;
    property U_Version : String read fU_Version write SetU_Version;
    property Vl_Parametro : String read fVl_Parametro write SetVl_Parametro;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TAdm_IprmList = class(TmCollection)
  private
    function GetItem(Index: Integer): TAdm_Iprm;
    procedure SetItem(Index: Integer; Value: TAdm_Iprm);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TAdm_Iprm;
    property Items[Index: Integer]: TAdm_Iprm read GetItem write SetItem; default;
  end;

implementation

{ TAdm_Iprm }

constructor TAdm_Iprm.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TAdm_Iprm.Destroy;
begin

  inherited;
end;

{ TAdm_IprmList }

constructor TAdm_IprmList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TAdm_Iprm);
end;

function TAdm_IprmList.Add: TAdm_Iprm;
begin
  Result := TAdm_Iprm(inherited Add);
  Result.create;
end;

function TAdm_IprmList.GetItem(Index: Integer): TAdm_Iprm;
begin
  Result := TAdm_Iprm(inherited GetItem(Index));
end;

procedure TAdm_IprmList.SetItem(Index: Integer; Value: TAdm_Iprm);
begin
  inherited SetItem(Index, Value);
end;

end.