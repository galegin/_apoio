unit uFcxCaixac;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Caixac = class;
  TFcx_CaixacClass = class of TFcx_Caixac;

  TFcx_CaixacList = class;
  TFcx_CaixacListClass = class of TFcx_CaixacList;

  TFcx_Caixac = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fCd_Opercx: String;
    fCd_Operconf: String;
    fNr_Ctapes: String;
    fDs_Fechamento: String;
    fVl_Abertura: String;
    fIn_Fechado: String;
    fDt_Fechado: String;
    fIn_Diferenca: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write SetDt_Abertura;
    property Nr_Seq : String read fNr_Seq write SetNr_Seq;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Opercx : String read fCd_Opercx write SetCd_Opercx;
    property Cd_Operconf : String read fCd_Operconf write SetCd_Operconf;
    property Nr_Ctapes : String read fNr_Ctapes write SetNr_Ctapes;
    property Ds_Fechamento : String read fDs_Fechamento write SetDs_Fechamento;
    property Vl_Abertura : String read fVl_Abertura write SetVl_Abertura;
    property In_Fechado : String read fIn_Fechado write SetIn_Fechado;
    property Dt_Fechado : String read fDt_Fechado write SetDt_Fechado;
    property In_Diferenca : String read fIn_Diferenca write SetIn_Diferenca;
  end;

  TFcx_CaixacList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixac;
    procedure SetItem(Index: Integer; Value: TFcx_Caixac);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Caixac;
    property Items[Index: Integer]: TFcx_Caixac read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Caixac }

constructor TFcx_Caixac.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Caixac.Destroy;
begin

  inherited;
end;

{ TFcx_CaixacList }

constructor TFcx_CaixacList.Create(AOwner: TPersistentCollection);
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