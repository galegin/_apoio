unit uAdmUsurepr;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Usurepr = class;
  TAdm_UsureprClass = class of TAdm_Usurepr;

  TAdm_UsureprList = class;
  TAdm_UsureprListClass = class of TAdm_UsureprList;

  TAdm_Usurepr = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Representant: Real;
    fTp_Sistema: Real;
    fCd_Emppadrao: Real;
    fIn_Empresa: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Representant : Real read fCd_Representant write fCd_Representant;
    property Tp_Sistema : Real read fTp_Sistema write fTp_Sistema;
    property Cd_Emppadrao : Real read fCd_Emppadrao write fCd_Emppadrao;
    property In_Empresa : String read fIn_Empresa write fIn_Empresa;
  end;

  TAdm_UsureprList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Usurepr;
    procedure SetItem(Index: Integer; Value: TAdm_Usurepr);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Usurepr;
    property Items[Index: Integer]: TAdm_Usurepr read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Usurepr }

constructor TAdm_Usurepr.Create;
begin

end;

destructor TAdm_Usurepr.Destroy;
begin

  inherited;
end;

{ TAdm_UsureprList }

constructor TAdm_UsureprList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Usurepr);
end;

function TAdm_UsureprList.Add: TAdm_Usurepr;
begin
  Result := TAdm_Usurepr(inherited Add);
  Result.create;
end;

function TAdm_UsureprList.GetItem(Index: Integer): TAdm_Usurepr;
begin
  Result := TAdm_Usurepr(inherited GetItem(Index));
end;

procedure TAdm_UsureprList.SetItem(Index: Integer; Value: TAdm_Usurepr);
begin
  inherited SetItem(Index, Value);
end;

end.