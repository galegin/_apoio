unit uTraTranref;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Tranref = class;
  TTra_TranrefClass = class of TTra_Tranref;

  TTra_TranrefList = class;
  TTra_TranrefListClass = class of TTra_TranrefList;

  TTra_Tranref = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empresanfref: Real;
    fNr_Faturanfref: Real;
    fDt_Faturanfref: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Referencial: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empresanfref : Real read fCd_Empresanfref write fCd_Empresanfref;
    property Nr_Faturanfref : Real read fNr_Faturanfref write fNr_Faturanfref;
    property Dt_Faturanfref : TDateTime read fDt_Faturanfref write fDt_Faturanfref;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Referencial : Real read fTp_Referencial write fTp_Referencial;
  end;

  TTra_TranrefList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Tranref;
    procedure SetItem(Index: Integer; Value: TTra_Tranref);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Tranref;
    property Items[Index: Integer]: TTra_Tranref read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Tranref }

constructor TTra_Tranref.Create;
begin

end;

destructor TTra_Tranref.Destroy;
begin

  inherited;
end;

{ TTra_TranrefList }

constructor TTra_TranrefList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Tranref);
end;

function TTra_TranrefList.Add: TTra_Tranref;
begin
  Result := TTra_Tranref(inherited Add);
  Result.create;
end;

function TTra_TranrefList.GetItem(Index: Integer): TTra_Tranref;
begin
  Result := TTra_Tranref(inherited GetItem(Index));
end;

procedure TTra_TranrefList.SetItem(Index: Integer; Value: TTra_Tranref);
begin
  inherited SetItem(Index, Value);
end;

end.