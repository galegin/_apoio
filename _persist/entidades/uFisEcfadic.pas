unit uFisEcfadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Ecfadic = class;
  TFis_EcfadicClass = class of TFis_Ecfadic;

  TFis_EcfadicList = class;
  TFis_EcfadicListClass = class of TFis_EcfadicList;

  TFis_Ecfadic = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Ecf: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Modcarne: Real;
    fNr_Viacarne: Real;
    fCd_Modrecibotra: Real;
    fNr_Viarecibotra: Real;
    fCd_Modrelcheq: Real;
    fNr_Viarelcheq: Real;
    fNr_Viacupomtef: Real;
    fIn_Cortevia: String;
    fNr_Linhacorte: Real;
    fNr_Totrec: Real;
    fNr_Totcancel: Real;
    fTp_Monitor: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Ecf : Real read fNr_Ecf write fNr_Ecf;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Modcarne : Real read fCd_Modcarne write fCd_Modcarne;
    property Nr_Viacarne : Real read fNr_Viacarne write fNr_Viacarne;
    property Cd_Modrecibotra : Real read fCd_Modrecibotra write fCd_Modrecibotra;
    property Nr_Viarecibotra : Real read fNr_Viarecibotra write fNr_Viarecibotra;
    property Cd_Modrelcheq : Real read fCd_Modrelcheq write fCd_Modrelcheq;
    property Nr_Viarelcheq : Real read fNr_Viarelcheq write fNr_Viarelcheq;
    property Nr_Viacupomtef : Real read fNr_Viacupomtef write fNr_Viacupomtef;
    property In_Cortevia : String read fIn_Cortevia write fIn_Cortevia;
    property Nr_Linhacorte : Real read fNr_Linhacorte write fNr_Linhacorte;
    property Nr_Totrec : Real read fNr_Totrec write fNr_Totrec;
    property Nr_Totcancel : Real read fNr_Totcancel write fNr_Totcancel;
    property Tp_Monitor : Real read fTp_Monitor write fTp_Monitor;
  end;

  TFis_EcfadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Ecfadic;
    procedure SetItem(Index: Integer; Value: TFis_Ecfadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Ecfadic;
    property Items[Index: Integer]: TFis_Ecfadic read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Ecfadic }

constructor TFis_Ecfadic.Create;
begin

end;

destructor TFis_Ecfadic.Destroy;
begin

  inherited;
end;

{ TFis_EcfadicList }

constructor TFis_EcfadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Ecfadic);
end;

function TFis_EcfadicList.Add: TFis_Ecfadic;
begin
  Result := TFis_Ecfadic(inherited Add);
  Result.create;
end;

function TFis_EcfadicList.GetItem(Index: Integer): TFis_Ecfadic;
begin
  Result := TFis_Ecfadic(inherited GetItem(Index));
end;

procedure TFis_EcfadicList.SetItem(Index: Integer; Value: TFis_Ecfadic);
begin
  inherited SetItem(Index, Value);
end;

end.