unit uFcxCaixac;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Caixac = class;
  TFcx_CaixacClass = class of TFcx_Caixac;

  TFcx_CaixacList = class;
  TFcx_CaixacListClass = class of TFcx_CaixacList;

  TFcx_Caixac = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fDt_Abertura: TDateTime;
    fNr_Seq: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Opercx: Real;
    fCd_Operconf: Real;
    fNr_Ctapes: Real;
    fDs_Fechamento: String;
    fVl_Abertura: Real;
    fIn_Fechado: String;
    fDt_Fechado: TDateTime;
    fIn_Diferenca: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Opercx : Real read fCd_Opercx write fCd_Opercx;
    property Cd_Operconf : Real read fCd_Operconf write fCd_Operconf;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Ds_Fechamento : String read fDs_Fechamento write fDs_Fechamento;
    property Vl_Abertura : Real read fVl_Abertura write fVl_Abertura;
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    property Dt_Fechado : TDateTime read fDt_Fechado write fDt_Fechado;
    property In_Diferenca : String read fIn_Diferenca write fIn_Diferenca;
  end;

  TFcx_CaixacList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixac;
    procedure SetItem(Index: Integer; Value: TFcx_Caixac);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Caixac;
    property Items[Index: Integer]: TFcx_Caixac read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Caixac }

constructor TFcx_Caixac.Create;
begin

end;

destructor TFcx_Caixac.Destroy;
begin

  inherited;
end;

{ TFcx_CaixacList }

constructor TFcx_CaixacList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Caixac);
end;

function TFcx_CaixacList.Add: TFcx_Caixac;
begin
  Result := TFcx_Caixac(inherited Add);
  Result.create;
end;

function TFcx_CaixacList.GetItem(Index: Integer): TFcx_Caixac;
begin
  Result := TFcx_Caixac(inherited GetItem(Index));
end;

procedure TFcx_CaixacList.SetItem(Index: Integer; Value: TFcx_Caixac);
begin
  inherited SetItem(Index, Value);
end;

end.