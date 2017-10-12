unit uGlbPais;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGlb_Pais = class;
  TGlb_PaisClass = class of TGlb_Pais;

  TGlb_PaisList = class;
  TGlb_PaisListClass = class of TGlb_PaisList;

  TGlb_Pais = class(TmCollectionItem)
  private
    fCd_Pais: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Pais: String;
    fCd_Paisbcb: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pais : String read fCd_Pais write SetCd_Pais;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Pais : String read fNm_Pais write SetNm_Pais;
    property Cd_Paisbcb : String read fCd_Paisbcb write SetCd_Paisbcb;
  end;

  TGlb_PaisList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGlb_Pais;
    procedure SetItem(Index: Integer; Value: TGlb_Pais);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGlb_Pais;
    property Items[Index: Integer]: TGlb_Pais read GetItem write SetItem; default;
  end;

implementation

{ TGlb_Pais }

constructor TGlb_Pais.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGlb_Pais.Destroy;
begin

  inherited;
end;

{ TGlb_PaisList }

constructor TGlb_PaisList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGlb_Pais);
end;

function TGlb_PaisList.Add: TGlb_Pais;
begin
  Result := TGlb_Pais(inherited Add);
  Result.create;
end;

function TGlb_PaisList.GetItem(Index: Integer): TGlb_Pais;
begin
  Result := TGlb_Pais(inherited GetItem(Index));
end;

procedure TGlb_PaisList.SetItem(Index: Integer; Value: TGlb_Pais);
begin
  inherited SetItem(Index, Value);
end;

end.