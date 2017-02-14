unit uTefTipotrans;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Tipotrans = class;
  TTef_TipotransClass = class of TTef_Tipotrans;

  TTef_TipotransList = class;
  TTef_TipotransListClass = class of TTef_TipotransList;

  TTef_Tipotrans = class(TcCollectionItem)
  private
    fTp_Tef: Real;
    fTp_Transacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Transacao: String;
    fTp_Opercredito: Real;
    fNr_Vias: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Tp_Transacao : Real read fTp_Transacao write fTp_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Transacao : String read fDs_Transacao write fDs_Transacao;
    property Tp_Opercredito : Real read fTp_Opercredito write fTp_Opercredito;
    property Nr_Vias : Real read fNr_Vias write fNr_Vias;
  end;

  TTef_TipotransList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Tipotrans;
    procedure SetItem(Index: Integer; Value: TTef_Tipotrans);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Tipotrans;
    property Items[Index: Integer]: TTef_Tipotrans read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Tipotrans }

constructor TTef_Tipotrans.Create;
begin

end;

destructor TTef_Tipotrans.Destroy;
begin

  inherited;
end;

{ TTef_TipotransList }

constructor TTef_TipotransList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Tipotrans);
end;

function TTef_TipotransList.Add: TTef_Tipotrans;
begin
  Result := TTef_Tipotrans(inherited Add);
  Result.create;
end;

function TTef_TipotransList.GetItem(Index: Integer): TTef_Tipotrans;
begin
  Result := TTef_Tipotrans(inherited GetItem(Index));
end;

procedure TTef_TipotransList.SetItem(Index: Integer; Value: TTef_Tipotrans);
begin
  inherited SetItem(Index, Value);
end;

end.