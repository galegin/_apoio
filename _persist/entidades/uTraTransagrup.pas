unit uTraTransagrup;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transagrup = class;
  TTra_TransagrupClass = class of TTra_Transagrup;

  TTra_TransagrupList = class;
  TTra_TransagrupListClass = class of TTra_TransagrupList;

  TTra_Transagrup = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empresaori: Real;
    fNr_Transacaoori: Real;
    fDt_Transacaoori: TDateTime;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Empfatori: Real;
    fCd_Grupoempori: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empresaori : Real read fCd_Empresaori write fCd_Empresaori;
    property Nr_Transacaoori : Real read fNr_Transacaoori write fNr_Transacaoori;
    property Dt_Transacaoori : TDateTime read fDt_Transacaoori write fDt_Transacaoori;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Empfatori : Real read fCd_Empfatori write fCd_Empfatori;
    property Cd_Grupoempori : Real read fCd_Grupoempori write fCd_Grupoempori;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_TransagrupList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transagrup;
    procedure SetItem(Index: Integer; Value: TTra_Transagrup);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transagrup;
    property Items[Index: Integer]: TTra_Transagrup read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transagrup }

constructor TTra_Transagrup.Create;
begin

end;

destructor TTra_Transagrup.Destroy;
begin

  inherited;
end;

{ TTra_TransagrupList }

constructor TTra_TransagrupList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transagrup);
end;

function TTra_TransagrupList.Add: TTra_Transagrup;
begin
  Result := TTra_Transagrup(inherited Add);
  Result.create;
end;

function TTra_TransagrupList.GetItem(Index: Integer): TTra_Transagrup;
begin
  Result := TTra_Transagrup(inherited GetItem(Index));
end;

procedure TTra_TransagrupList.SetItem(Index: Integer; Value: TTra_Transagrup);
begin
  inherited SetItem(Index, Value);
end;

end.