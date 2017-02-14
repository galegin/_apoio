unit uAdmIprm;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Iprm = class;
  TAdm_IprmClass = class of TAdm_Iprm;

  TAdm_IprmList = class;
  TAdm_IprmListClass = class of TAdm_IprmList;

  TAdm_Iprm = class(TcCollectionItem)
  private
    fCd_Parametro: String;
    fU_Version: String;
    fVl_Parametro: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Parametro : String read fCd_Parametro write fCd_Parametro;
    property U_Version : String read fU_Version write fU_Version;
    property Vl_Parametro : String read fVl_Parametro write fVl_Parametro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TAdm_IprmList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Iprm;
    procedure SetItem(Index: Integer; Value: TAdm_Iprm);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Iprm;
    property Items[Index: Integer]: TAdm_Iprm read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Iprm }

constructor TAdm_Iprm.Create;
begin

end;

destructor TAdm_Iprm.Destroy;
begin

  inherited;
end;

{ TAdm_IprmList }

constructor TAdm_IprmList.Create(AOwner: TPersistent);
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