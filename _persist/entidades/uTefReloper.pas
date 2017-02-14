unit uTefReloper;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Reloper = class;
  TTef_ReloperClass = class of TTef_Reloper;

  TTef_ReloperList = class;
  TTef_ReloperListClass = class of TTef_ReloperList;

  TTef_Reloper = class(TcCollectionItem)
  private
    fTp_Tef: Real;
    fCd_Redetef: Real;
    fTp_Transacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Portador: Real;
    fCd_Opercredito: Real;
    fNr_Portadoroper: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Tp_Tef : Real read fTp_Tef write fTp_Tef;
    property Cd_Redetef : Real read fCd_Redetef write fCd_Redetef;
    property Tp_Transacao : Real read fTp_Transacao write fTp_Transacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Cd_Opercredito : Real read fCd_Opercredito write fCd_Opercredito;
    property Nr_Portadoroper : Real read fNr_Portadoroper write fNr_Portadoroper;
  end;

  TTef_ReloperList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Reloper;
    procedure SetItem(Index: Integer; Value: TTef_Reloper);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Reloper;
    property Items[Index: Integer]: TTef_Reloper read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Reloper }

constructor TTef_Reloper.Create;
begin

end;

destructor TTef_Reloper.Destroy;
begin

  inherited;
end;

{ TTef_ReloperList }

constructor TTef_ReloperList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Reloper);
end;

function TTef_ReloperList.Add: TTef_Reloper;
begin
  Result := TTef_Reloper(inherited Add);
  Result.create;
end;

function TTef_ReloperList.GetItem(Index: Integer): TTef_Reloper;
begin
  Result := TTef_Reloper(inherited GetItem(Index));
end;

procedure TTef_ReloperList.SetItem(Index: Integer; Value: TTef_Reloper);
begin
  inherited SetItem(Index, Value);
end;

end.