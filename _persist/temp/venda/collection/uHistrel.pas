unit uHistrel;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  THistrel = class;
  THistrelClass = class of THistrel;

  THistrelList = class;
  THistrelListClass = class of THistrelList;

  THistrel = class(TmCollectionItem)
  private
    fId_Histrel: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fTp_Documento: Integer;
    fCd_Histrel: Integer;
    fDs_Histrel: String;
    fNr_Parcelas: Integer;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Histrel : Integer read fId_Histrel write SetId_Histrel;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Documento : Integer read fTp_Documento write SetTp_Documento;
    property Cd_Histrel : Integer read fCd_Histrel write SetCd_Histrel;
    property Ds_Histrel : String read fDs_Histrel write SetDs_Histrel;
    property Nr_Parcelas : Integer read fNr_Parcelas write SetNr_Parcelas;
  end;

  THistrelList = class(TmCollection)
  private
    function GetItem(Index: Integer): THistrel;
    procedure SetItem(Index: Integer; Value: THistrel);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: THistrel;
    property Items[Index: Integer]: THistrel read GetItem write SetItem; default;
  end;

implementation

{ THistrel }

constructor THistrel.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor THistrel.Destroy;
begin

  inherited;
end;

{ THistrelList }

constructor THistrelList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(THistrel);
end;

function THistrelList.Add: THistrel;
begin
  Result := THistrel(inherited Add);
  Result.create;
end;

function THistrelList.GetItem(Index: Integer): THistrel;
begin
  Result := THistrel(inherited GetItem(Index));
end;

procedure THistrelList.SetItem(Index: Integer; Value: THistrel);
begin
  inherited SetItem(Index, Value);
end;

end.