unit uFcxMalotefati;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Malotefati = class;
  TFcx_MalotefatiClass = class of TFcx_Malotefati;

  TFcx_MalotefatiList = class;
  TFcx_MalotefatiListClass = class of TFcx_MalotefatiList;

  TFcx_Malotefati = class(TcCollectionItem)
  private
    fCd_Grupoempresa: Real;
    fNr_Ctapes: Real;
    fDt_Movimento: TDateTime;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fNr_Seqmalote: Real;
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fat: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Nr_Seqmalote : Real read fNr_Seqmalote write fNr_Seqmalote;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fat : Real read fNr_Fat write fNr_Fat;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_MalotefatiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Malotefati;
    procedure SetItem(Index: Integer; Value: TFcx_Malotefati);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Malotefati;
    property Items[Index: Integer]: TFcx_Malotefati read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Malotefati }

constructor TFcx_Malotefati.Create;
begin

end;

destructor TFcx_Malotefati.Destroy;
begin

  inherited;
end;

{ TFcx_MalotefatiList }

constructor TFcx_MalotefatiList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Malotefati);
end;

function TFcx_MalotefatiList.Add: TFcx_Malotefati;
begin
  Result := TFcx_Malotefati(inherited Add);
  Result.create;
end;

function TFcx_MalotefatiList.GetItem(Index: Integer): TFcx_Malotefati;
begin
  Result := TFcx_Malotefati(inherited GetItem(Index));
end;

procedure TFcx_MalotefatiList.SetItem(Index: Integer; Value: TFcx_Malotefati);
begin
  inherited SetItem(Index, Value);
end;

end.