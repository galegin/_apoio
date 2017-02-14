unit uTraTransacecf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacecf = class;
  TTra_TransacecfClass = class of TTra_Transacecf;

  TTra_TransacecfList = class;
  TTra_TransacecfListClass = class of TTra_TransacecfList;

  TTra_Transacecf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fU_Version: String;
    fCd_Empecf: Real;
    fNr_Ecf: Real;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: String;
    fNr_Cupom: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empecf : Real read fCd_Empecf write fCd_Empecf;
    property Nr_Ecf : Real read fNr_Ecf write fNr_Ecf;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Nr_Cupom : Real read fNr_Cupom write fNr_Cupom;
  end;

  TTra_TransacecfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacecf;
    procedure SetItem(Index: Integer; Value: TTra_Transacecf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacecf;
    property Items[Index: Integer]: TTra_Transacecf read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacecf }

constructor TTra_Transacecf.Create;
begin

end;

destructor TTra_Transacecf.Destroy;
begin

  inherited;
end;

{ TTra_TransacecfList }

constructor TTra_TransacecfList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacecf);
end;

function TTra_TransacecfList.Add: TTra_Transacecf;
begin
  Result := TTra_Transacecf(inherited Add);
  Result.create;
end;

function TTra_TransacecfList.GetItem(Index: Integer): TTra_Transacecf;
begin
  Result := TTra_Transacecf(inherited GetItem(Index));
end;

procedure TTra_TransacecfList.SetItem(Index: Integer; Value: TTra_Transacecf);
begin
  inherited SetItem(Index, Value);
end;

end.