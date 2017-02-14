unit uFcxCaixai;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Caixai = class;
  TFcx_CaixaiClass = class of TFcx_Caixai;

  TFcx_CaixaiList = class;
  TFcx_CaixaiListClass = class of TFcx_CaixaiList;

  TFcx_Caixai = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fDt_Abertura: TDateTime;
    fNr_Seq: Real;
    fNr_Seqitem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fNr_Portador: Real;
    fVl_Contado: Real;
    fVl_Sistema: Real;
    fVl_Diferenca: Real;
    fVl_Fundo: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Nr_Seqitem : Real read fNr_Seqitem write fNr_Seqitem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Vl_Contado : Real read fVl_Contado write fVl_Contado;
    property Vl_Sistema : Real read fVl_Sistema write fVl_Sistema;
    property Vl_Diferenca : Real read fVl_Diferenca write fVl_Diferenca;
    property Vl_Fundo : Real read fVl_Fundo write fVl_Fundo;
  end;

  TFcx_CaixaiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixai;
    procedure SetItem(Index: Integer; Value: TFcx_Caixai);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Caixai;
    property Items[Index: Integer]: TFcx_Caixai read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Caixai }

constructor TFcx_Caixai.Create;
begin

end;

destructor TFcx_Caixai.Destroy;
begin

  inherited;
end;

{ TFcx_CaixaiList }

constructor TFcx_CaixaiList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Caixai);
end;

function TFcx_CaixaiList.Add: TFcx_Caixai;
begin
  Result := TFcx_Caixai(inherited Add);
  Result.create;
end;

function TFcx_CaixaiList.GetItem(Index: Integer): TFcx_Caixai;
begin
  Result := TFcx_Caixai(inherited GetItem(Index));
end;

procedure TFcx_CaixaiList.SetItem(Index: Integer; Value: TFcx_Caixai);
begin
  inherited SetItem(Index, Value);
end;

end.