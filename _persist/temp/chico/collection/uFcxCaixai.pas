unit uFcxCaixai;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Caixai = class;
  TFcx_CaixaiClass = class of TFcx_Caixai;

  TFcx_CaixaiList = class;
  TFcx_CaixaiListClass = class of TFcx_CaixaiList;

  TFcx_Caixai = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fNr_Seqitem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Documento: String;
    fNr_Seqhistrelsub: String;
    fNr_Portador: String;
    fVl_Contado: String;
    fVl_Sistema: String;
    fVl_Diferenca: String;
    fVl_Fundo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write SetDt_Abertura;
    property Nr_Seq : String read fNr_Seq write SetNr_Seq;
    property Nr_Seqitem : String read fNr_Seqitem write SetNr_Seqitem;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Documento : String read fTp_Documento write SetTp_Documento;
    property Nr_Seqhistrelsub : String read fNr_Seqhistrelsub write SetNr_Seqhistrelsub;
    property Nr_Portador : String read fNr_Portador write SetNr_Portador;
    property Vl_Contado : String read fVl_Contado write SetVl_Contado;
    property Vl_Sistema : String read fVl_Sistema write SetVl_Sistema;
    property Vl_Diferenca : String read fVl_Diferenca write SetVl_Diferenca;
    property Vl_Fundo : String read fVl_Fundo write SetVl_Fundo;
  end;

  TFcx_CaixaiList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixai;
    procedure SetItem(Index: Integer; Value: TFcx_Caixai);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Caixai;
    property Items[Index: Integer]: TFcx_Caixai read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Caixai }

constructor TFcx_Caixai.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Caixai.Destroy;
begin

  inherited;
end;

{ TFcx_CaixaiList }

constructor TFcx_CaixaiList.Create(AOwner: TPersistentCollection);
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