unit uSisSessao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TSis_Sessao = class;
  TSis_SessaoClass = class of TSis_Sessao;

  TSis_SessaoList = class;
  TSis_SessaoListClass = class of TSis_SessaoList;

  TSis_Sessao = class(TcCollectionItem)
  private
    fNr_Sessao: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Usuario: Real;
    fDt_Logon: TDateTime;
    fDt_Logout: TDateTime;
    fDt_Ultimoacesso: TDateTime;
    fIn_Encerrar: String;
    fNm_Computador: String;
    fCd_Ultimocomponente: String;
    fDs_Ip: String;
    fCd_Empresa: Real;
    fTp_Privilegio: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Sessao : Real read fNr_Sessao write fNr_Sessao;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Dt_Logon : TDateTime read fDt_Logon write fDt_Logon;
    property Dt_Logout : TDateTime read fDt_Logout write fDt_Logout;
    property Dt_Ultimoacesso : TDateTime read fDt_Ultimoacesso write fDt_Ultimoacesso;
    property In_Encerrar : String read fIn_Encerrar write fIn_Encerrar;
    property Nm_Computador : String read fNm_Computador write fNm_Computador;
    property Cd_Ultimocomponente : String read fCd_Ultimocomponente write fCd_Ultimocomponente;
    property Ds_Ip : String read fDs_Ip write fDs_Ip;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Tp_Privilegio : String read fTp_Privilegio write fTp_Privilegio;
  end;

  TSis_SessaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TSis_Sessao;
    procedure SetItem(Index: Integer; Value: TSis_Sessao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TSis_Sessao;
    property Items[Index: Integer]: TSis_Sessao read GetItem write SetItem; default;
  end;
  
implementation

{ TSis_Sessao }

constructor TSis_Sessao.Create;
begin

end;

destructor TSis_Sessao.Destroy;
begin

  inherited;
end;

{ TSis_SessaoList }

constructor TSis_SessaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TSis_Sessao);
end;

function TSis_SessaoList.Add: TSis_Sessao;
begin
  Result := TSis_Sessao(inherited Add);
  Result.create;
end;

function TSis_SessaoList.GetItem(Index: Integer): TSis_Sessao;
begin
  Result := TSis_Sessao(inherited GetItem(Index));
end;

procedure TSis_SessaoList.SetItem(Index: Integer; Value: TSis_Sessao);
begin
  inherited SetItem(Index, Value);
end;

end.