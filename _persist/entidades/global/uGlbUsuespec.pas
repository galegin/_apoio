unit uGlbUsuespec;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Usuespec = class;
  TGlb_UsuespecClass = class of TGlb_Usuespec;

  TGlb_UsuespecList = class;
  TGlb_UsuespecListClass = class of TGlb_UsuespecList;

  TGlb_Usuespec = class(TcCollectionItem)
  private
    fCd_Usuario: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Usuario: String;
    fNm_Login: String;
    fCd_Senha: String;
    fTp_Privilegio: String;
    fTp_Bloqueio: Real;
    fDt_Bloqueio: TDateTime;
    fDs_Escritorio: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Usuario : String read fNm_Usuario write fNm_Usuario;
    property Nm_Login : String read fNm_Login write fNm_Login;
    property Cd_Senha : String read fCd_Senha write fCd_Senha;
    property Tp_Privilegio : String read fTp_Privilegio write fTp_Privilegio;
    property Tp_Bloqueio : Real read fTp_Bloqueio write fTp_Bloqueio;
    property Dt_Bloqueio : TDateTime read fDt_Bloqueio write fDt_Bloqueio;
    property Ds_Escritorio : String read fDs_Escritorio write fDs_Escritorio;
  end;

  TGlb_UsuespecList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Usuespec;
    procedure SetItem(Index: Integer; Value: TGlb_Usuespec);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Usuespec;
    property Items[Index: Integer]: TGlb_Usuespec read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Usuespec }

constructor TGlb_Usuespec.Create;
begin

end;

destructor TGlb_Usuespec.Destroy;
begin

  inherited;
end;

{ TGlb_UsuespecList }

constructor TGlb_UsuespecList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Usuespec);
end;

function TGlb_UsuespecList.Add: TGlb_Usuespec;
begin
  Result := TGlb_Usuespec(inherited Add);
  Result.create;
end;

function TGlb_UsuespecList.GetItem(Index: Integer): TGlb_Usuespec;
begin
  Result := TGlb_Usuespec(inherited GetItem(Index));
end;

procedure TGlb_UsuespecList.SetItem(Index: Integer; Value: TGlb_Usuespec);
begin
  inherited SetItem(Index, Value);
end;

end.