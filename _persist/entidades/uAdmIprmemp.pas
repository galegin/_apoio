unit uAdmIprmemp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Iprmemp = class;
  TAdm_IprmempClass = class of TAdm_Iprmemp;

  TAdm_IprmempList = class;
  TAdm_IprmempListClass = class of TAdm_IprmempList;

  TAdm_Iprmemp = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Parametro: String;
    fU_Version: String;
    fVl_Parametro: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Parametro : String read fCd_Parametro write fCd_Parametro;
    property U_Version : String read fU_Version write fU_Version;
    property Vl_Parametro : String read fVl_Parametro write fVl_Parametro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TAdm_IprmempList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Iprmemp;
    procedure SetItem(Index: Integer; Value: TAdm_Iprmemp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Iprmemp;
    property Items[Index: Integer]: TAdm_Iprmemp read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Iprmemp }

constructor TAdm_Iprmemp.Create;
begin

end;

destructor TAdm_Iprmemp.Destroy;
begin

  inherited;
end;

{ TAdm_IprmempList }

constructor TAdm_IprmempList.Create(AOwner: TPersistent);
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