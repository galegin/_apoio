unit uGlbPais;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Pais = class;
  TGlb_PaisClass = class of TGlb_Pais;

  TGlb_PaisList = class;
  TGlb_PaisListClass = class of TGlb_PaisList;

  TGlb_Pais = class(TcCollectionItem)
  private
    fCd_Pais: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Pais: String;
    fCd_Paisbcb: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pais : Real read fCd_Pais write fCd_Pais;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Pais : String read fNm_Pais write fNm_Pais;
    property Cd_Paisbcb : Real read fCd_Paisbcb write fCd_Paisbcb;
  end;

  TGlb_PaisList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Pais;
    procedure SetItem(Index: Integer; Value: TGlb_Pais);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Pais;
    property Items[Index: Integer]: TGlb_Pais read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Pais }

constructor TGlb_Pais.Create;
begin

end;

destructor TGlb_Pais.Destroy;
begin

  inherited;
end;

{ TGlb_PaisList }

constructor TGlb_PaisList.Create(AOwner: TPersistent);
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