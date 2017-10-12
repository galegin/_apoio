unit uAdmIprmemp;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TAdm_Iprmemp = class;
  TAdm_IprmempClass = class of TAdm_Iprmemp;

  TAdm_IprmempList = class;
  TAdm_IprmempListClass = class of TAdm_IprmempList;

  TAdm_Iprmemp = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Parametro: String;
    fU_Version: String;
    fVl_Parametro: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Parametro : String read fCd_Parametro write SetCd_Parametro;
    property U_Version : String read fU_Version write SetU_Version;
    property Vl_Parametro : String read fVl_Parametro write SetVl_Parametro;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TAdm_IprmempList = class(TmCollection)
  private
    function GetItem(Index: Integer): TAdm_Iprmemp;
    procedure SetItem(Index: Integer; Value: TAdm_Iprmemp);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TAdm_Iprmemp;
    property Items[Index: Integer]: TAdm_Iprmemp read GetItem write SetItem; default;
  end;

implementation

{ TAdm_Iprmemp }

constructor TAdm_Iprmemp.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TAdm_Iprmemp.Destroy;
begin

  inherited;
end;

{ TAdm_IprmempList }

constructor TAdm_IprmempList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TAdm_Iprmemp);
end;

function TAdm_IprmempList.Add: TAdm_Iprmemp;
begin
  Result := TAdm_Iprmemp(inherited Add);
  Result.create;
end;

function TAdm_IprmempList.GetItem(Index: Integer): TAdm_Iprmemp;
begin
  Result := TAdm_Iprmemp(inherited GetItem(Index));
end;

procedure TAdm_IprmempList.SetItem(Index: Integer; Value: TAdm_Iprmemp);
begin
  inherited SetItem(Index, Value);
end;

end.