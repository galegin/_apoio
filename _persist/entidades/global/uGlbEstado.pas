unit uGlbEstado;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Estado = class;
  TGlb_EstadoClass = class of TGlb_Estado;

  TGlb_EstadoList = class;
  TGlb_EstadoListClass = class of TGlb_EstadoList;

  TGlb_Estado = class(TcCollectionItem)
  private
    fCd_Estado: Real;
    fU_Version: String;
    fCd_Pais: Real;
    fDs_Sigla: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Estado: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Estado : Real read fCd_Estado write fCd_Estado;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Pais : Real read fCd_Pais write fCd_Pais;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Estado : String read fNm_Estado write fNm_Estado;
  end;

  TGlb_EstadoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Estado;
    procedure SetItem(Index: Integer; Value: TGlb_Estado);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Estado;
    property Items[Index: Integer]: TGlb_Estado read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Estado }

constructor TGlb_Estado.Create;
begin

end;

destructor TGlb_Estado.Destroy;
begin

  inherited;
end;

{ TGlb_EstadoList }

constructor TGlb_EstadoList.Create(AOwner: TPersistent);
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