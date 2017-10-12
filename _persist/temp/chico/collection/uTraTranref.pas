unit uTraTranref;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Tranref = class;
  TTra_TranrefClass = class of TTra_Tranref;

  TTra_TranrefList = class;
  TTra_TranrefListClass = class of TTra_TranrefList;

  TTra_Tranref = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fCd_Empresanfref: String;
    fNr_Faturanfref: String;
    fDt_Faturanfref: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Referencial: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Cd_Empresanfref : String read fCd_Empresanfref write SetCd_Empresanfref;
    property Nr_Faturanfref : String read fNr_Faturanfref write SetNr_Faturanfref;
    property Dt_Faturanfref : String read fDt_Faturanfref write SetDt_Faturanfref;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Referencial : String read fTp_Referencial write SetTp_Referencial;
  end;

  TTra_TranrefList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Tranref;
    procedure SetItem(Index: Integer; Value: TTra_Tranref);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Tranref;
    property Items[Index: Integer]: TTra_Tranref read GetItem write SetItem; default;
  end;

implementation

{ TTra_Tranref }

constructor TTra_Tranref.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Tranref.Destroy;
begin

  inherited;
end;

{ TTra_TranrefList }

constructor TTra_TranrefList.Create(AOwner: TPersistentCollection);
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