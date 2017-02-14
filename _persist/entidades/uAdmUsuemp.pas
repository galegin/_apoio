unit uAdmUsuemp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Usuemp = class;
  TAdm_UsuempClass = class of TAdm_Usuemp;

  TAdm_UsuempList = class;
  TAdm_UsuempListClass = class of TAdm_UsuempList;

  TAdm_Usuemp = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fCd_Empresa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Nivel: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Nivel : Real read fCd_Nivel write fCd_Nivel;
  end;

  TAdm_UsuempList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Usuemp;
    procedure SetItem(Index: Integer; Value: TAdm_Usuemp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Usuemp;
    property Items[Index: Integer]: TAdm_Usuemp read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Usuemp }

constructor TAdm_Usuemp.Create;
begin

end;

destructor TAdm_Usuemp.Destroy;
begin

  inherited;
end;

{ TAdm_UsuempList }

constructor TAdm_UsuempList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Usuemp);
end;

function TAdm_UsuempList.Add: TAdm_Usuemp;
begin
  Result := TAdm_Usuemp(inherited Add);
  Result.create;
end;

function TAdm_UsuempList.GetItem(Index: Integer): TAdm_Usuemp;
begin
  Result := TAdm_Usuemp(inherited GetItem(Index));
end;

procedure TAdm_UsuempList.SetItem(Index: Integer; Value: TAdm_Usuemp);
begin
  inherited SetItem(Index, Value);
end;

end.