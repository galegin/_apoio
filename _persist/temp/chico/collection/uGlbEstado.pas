unit uGlbEstado;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGlb_Estado = class;
  TGlb_EstadoClass = class of TGlb_Estado;

  TGlb_EstadoList = class;
  TGlb_EstadoListClass = class of TGlb_EstadoList;

  TGlb_Estado = class(TmCollectionItem)
  private
    fCd_Estado: String;
    fU_Version: String;
    fCd_Pais: String;
    fDs_Sigla: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Estado: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Estado : String read fCd_Estado write SetCd_Estado;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Pais : String read fCd_Pais write SetCd_Pais;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Estado : String read fNm_Estado write SetNm_Estado;
  end;

  TGlb_EstadoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGlb_Estado;
    procedure SetItem(Index: Integer; Value: TGlb_Estado);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGlb_Estado;
    property Items[Index: Integer]: TGlb_Estado read GetItem write SetItem; default;
  end;

implementation

{ TGlb_Estado }

constructor TGlb_Estado.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGlb_Estado.Destroy;
begin

  inherited;
end;

{ TGlb_EstadoList }

constructor TGlb_EstadoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGlb_Estado);
end;

function TGlb_EstadoList.Add: TGlb_Estado;
begin
  Result := TGlb_Estado(inherited Add);
  Result.create;
end;

function TGlb_EstadoList.GetItem(Index: Integer): TGlb_Estado;
begin
  Result := TGlb_Estado(inherited GetItem(Index));
end;

procedure TGlb_EstadoList.SetItem(Index: Integer; Value: TGlb_Estado);
begin
  inherited SetItem(Index, Value);
end;

end.