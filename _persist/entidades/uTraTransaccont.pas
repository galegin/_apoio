unit uTraTransaccont;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transaccont = class;
  TTra_TransaccontClass = class of TTra_Transaccont;

  TTra_TransaccontList = class;
  TTra_TransaccontListClass = class of TTra_TransaccontList;

  TTra_Transaccont = class(TcCollectionItem)
  private
    fCd_Emptransacao: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empcontagem: Real;
    fNr_Contagem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Situacao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Emptransacao : Real read fCd_Emptransacao write fCd_Emptransacao;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empcontagem : Real read fCd_Empcontagem write fCd_Empcontagem;
    property Nr_Contagem : Real read fNr_Contagem write fNr_Contagem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
  end;

  TTra_TransaccontList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transaccont;
    procedure SetItem(Index: Integer; Value: TTra_Transaccont);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transaccont;
    property Items[Index: Integer]: TTra_Transaccont read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transaccont }

constructor TTra_Transaccont.Create;
begin

end;

destructor TTra_Transaccont.Destroy;
begin

  inherited;
end;

{ TTra_TransaccontList }

constructor TTra_TransaccontList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transaccont);
end;

function TTra_TransaccontList.Add: TTra_Transaccont;
begin
  Result := TTra_Transaccont(inherited Add);
  Result.create;
end;

function TTra_TransaccontList.GetItem(Index: Integer): TTra_Transaccont;
begin
  Result := TTra_Transaccont(inherited GetItem(Index));
end;

procedure TTra_TransaccontList.SetItem(Index: Integer; Value: TTra_Transaccont);
begin
  inherited SetItem(Index, Value);
end;

end.