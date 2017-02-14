unit uTraTransob;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transob = class;
  TTra_TransobClass = class of TTra_Transob;

  TTra_TransobList = class;
  TTra_TransobListClass = class of TTra_TransobList;

  TTra_Transob = class(TcCollectionItem)
  private
    fCd_Emptra: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Item: Real;
    fCd_Empotn: Real;
    fCd_Otn: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Emptra : Real read fCd_Emptra write fCd_Emptra;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Empotn : Real read fCd_Empotn write fCd_Empotn;
    property Cd_Otn : String read fCd_Otn write fCd_Otn;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTra_TransobList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transob;
    procedure SetItem(Index: Integer; Value: TTra_Transob);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transob;
    property Items[Index: Integer]: TTra_Transob read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transob }

constructor TTra_Transob.Create;
begin

end;

destructor TTra_Transob.Destroy;
begin

  inherited;
end;

{ TTra_TransobList }

constructor TTra_TransobList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transob);
end;

function TTra_TransobList.Add: TTra_Transob;
begin
  Result := TTra_Transob(inherited Add);
  Result.create;
end;

function TTra_TransobList.GetItem(Index: Integer): TTra_Transob;
begin
  Result := TTra_Transob(inherited GetItem(Index));
end;

procedure TTra_TransobList.SetItem(Index: Integer; Value: TTra_Transob);
begin
  inherited SetItem(Index, Value);
end;

end.