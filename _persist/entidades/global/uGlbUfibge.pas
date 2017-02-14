unit uGlbUfibge;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Ufibge = class;
  TGlb_UfibgeClass = class of TGlb_Ufibge;

  TGlb_UfibgeList = class;
  TGlb_UfibgeListClass = class of TGlb_UfibgeList;

  TGlb_Ufibge = class(TcCollectionItem)
  private
    fDs_Sigla: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Uf: Real;
    fNm_Uf: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Uf : Real read fCd_Uf write fCd_Uf;
    property Nm_Uf : String read fNm_Uf write fNm_Uf;
  end;

  TGlb_UfibgeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Ufibge;
    procedure SetItem(Index: Integer; Value: TGlb_Ufibge);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Ufibge;
    property Items[Index: Integer]: TGlb_Ufibge read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Ufibge }

constructor TGlb_Ufibge.Create;
begin

end;

destructor TGlb_Ufibge.Destroy;
begin

  inherited;
end;

{ TGlb_UfibgeList }

constructor TGlb_UfibgeList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Ufibge);
end;

function TGlb_UfibgeList.Add: TGlb_Ufibge;
begin
  Result := TGlb_Ufibge(inherited Add);
  Result.create;
end;

function TGlb_UfibgeList.GetItem(Index: Integer): TGlb_Ufibge;
begin
  Result := TGlb_Ufibge(inherited GetItem(Index));
end;

procedure TGlb_UfibgeList.SetItem(Index: Integer; Value: TGlb_Ufibge);
begin
  inherited SetItem(Index, Value);
end;

end.