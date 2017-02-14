unit uGlbMunibge;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Munibge = class;
  TGlb_MunibgeClass = class of TGlb_Munibge;

  TGlb_MunibgeList = class;
  TGlb_MunibgeListClass = class of TGlb_MunibgeList;

  TGlb_Munibge = class(TcCollectionItem)
  private
    fCd_Estado: Real;
    fCd_Municipio: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Municipioibge: Real;
    fCd_Distrito: Real;
    fCd_Subdistrito: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Estado : Real read fCd_Estado write fCd_Estado;
    property Cd_Municipio : Real read fCd_Municipio write fCd_Municipio;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Municipioibge : Real read fCd_Municipioibge write fCd_Municipioibge;
    property Cd_Distrito : Real read fCd_Distrito write fCd_Distrito;
    property Cd_Subdistrito : Real read fCd_Subdistrito write fCd_Subdistrito;
  end;

  TGlb_MunibgeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Munibge;
    procedure SetItem(Index: Integer; Value: TGlb_Munibge);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Munibge;
    property Items[Index: Integer]: TGlb_Munibge read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Munibge }

constructor TGlb_Munibge.Create;
begin

end;

destructor TGlb_Munibge.Destroy;
begin

  inherited;
end;

{ TGlb_MunibgeList }

constructor TGlb_MunibgeList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Munibge);
end;

function TGlb_MunibgeList.Add: TGlb_Munibge;
begin
  Result := TGlb_Munibge(inherited Add);
  Result.create;
end;

function TGlb_MunibgeList.GetItem(Index: Integer): TGlb_Munibge;
begin
  Result := TGlb_Munibge(inherited GetItem(Index));
end;

procedure TGlb_MunibgeList.SetItem(Index: Integer; Value: TGlb_Munibge);
begin
  inherited SetItem(Index, Value);
end;

end.