unit uTraTransacr;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacr = class;
  TTra_TransacrClass = class of TTra_Transacr;

  TTra_TransacrList = class;
  TTra_TransacrListClass = class of TTra_TransacrList;

  TTra_Transacr = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empdest: Real;
    fNr_Tradest: Real;
    fDt_Tradest: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Relaciona: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empdest : Real read fCd_Empdest write fCd_Empdest;
    property Nr_Tradest : Real read fNr_Tradest write fNr_Tradest;
    property Dt_Tradest : TDateTime read fDt_Tradest write fDt_Tradest;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Relaciona : Real read fTp_Relaciona write fTp_Relaciona;
  end;

  TTra_TransacrList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacr;
    procedure SetItem(Index: Integer; Value: TTra_Transacr);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacr;
    property Items[Index: Integer]: TTra_Transacr read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacr }

constructor TTra_Transacr.Create;
begin

end;

destructor TTra_Transacr.Destroy;
begin

  inherited;
end;

{ TTra_TransacrList }

constructor TTra_TransacrList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacr);
end;

function TTra_TransacrList.Add: TTra_Transacr;
begin
  Result := TTra_Transacr(inherited Add);
  Result.create;
end;

function TTra_TransacrList.GetItem(Index: Integer): TTra_Transacr;
begin
  Result := TTra_Transacr(inherited GetItem(Index));
end;

procedure TTra_TransacrList.SetItem(Index: Integer; Value: TTra_Transacr);
begin
  inherited SetItem(Index, Value);
end;

end.