unit uAdmLnlog;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Lnlog = class;
  TAdm_LnlogClass = class of TAdm_Lnlog;

  TAdm_LnlogList = class;
  TAdm_LnlogListClass = class of TAdm_LnlogList;

  TAdm_Lnlog = class(TcCollectionItem)
  private
    fDt_Evento: TDateTime;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Usuario: Real;
    fCd_Componente: String;
    fCd_Nivel: Real;
    fNr_Sessao: Real;
    fVl_Parametro: Real;
    fTp_Log: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Dt_Evento : TDateTime read fDt_Evento write fDt_Evento;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Usuario : Real read fCd_Usuario write fCd_Usuario;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Cd_Nivel : Real read fCd_Nivel write fCd_Nivel;
    property Nr_Sessao : Real read fNr_Sessao write fNr_Sessao;
    property Vl_Parametro : Real read fVl_Parametro write fVl_Parametro;
    property Tp_Log : Real read fTp_Log write fTp_Log;
  end;

  TAdm_LnlogList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Lnlog;
    procedure SetItem(Index: Integer; Value: TAdm_Lnlog);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Lnlog;
    property Items[Index: Integer]: TAdm_Lnlog read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Lnlog }

constructor TAdm_Lnlog.Create;
begin

end;

destructor TAdm_Lnlog.Destroy;
begin

  inherited;
end;

{ TAdm_LnlogList }

constructor TAdm_LnlogList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Lnlog);
end;

function TAdm_LnlogList.Add: TAdm_Lnlog;
begin
  Result := TAdm_Lnlog(inherited Add);
  Result.create;
end;

function TAdm_LnlogList.GetItem(Index: Integer): TAdm_Lnlog;
begin
  Result := TAdm_Lnlog(inherited GetItem(Index));
end;

procedure TAdm_LnlogList.SetItem(Index: Integer; Value: TAdm_Lnlog);
begin
  inherited SetItem(Index, Value);
end;

end.