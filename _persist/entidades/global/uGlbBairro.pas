unit uGlbBairro;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Bairro = class;
  TGlb_BairroClass = class of TGlb_Bairro;

  TGlb_BairroList = class;
  TGlb_BairroListClass = class of TGlb_BairroList;

  TGlb_Bairro = class(TcCollectionItem)
  private
    fCd_Municipio: Real;
    fCd_Bairro: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Bairro: String;
    fDs_Abreviado: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Municipio : Real read fCd_Municipio write fCd_Municipio;
    property Cd_Bairro : Real read fCd_Bairro write fCd_Bairro;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Bairro : String read fNm_Bairro write fNm_Bairro;
    property Ds_Abreviado : String read fDs_Abreviado write fDs_Abreviado;
  end;

  TGlb_BairroList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Bairro;
    procedure SetItem(Index: Integer; Value: TGlb_Bairro);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Bairro;
    property Items[Index: Integer]: TGlb_Bairro read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Bairro }

constructor TGlb_Bairro.Create;
begin

end;

destructor TGlb_Bairro.Destroy;
begin

  inherited;
end;

{ TGlb_BairroList }

constructor TGlb_BairroList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Bairro);
end;

function TGlb_BairroList.Add: TGlb_Bairro;
begin
  Result := TGlb_Bairro(inherited Add);
  Result.create;
end;

function TGlb_BairroList.GetItem(Index: Integer): TGlb_Bairro;
begin
  Result := TGlb_Bairro(inherited GetItem(Index));
end;

procedure TGlb_BairroList.SetItem(Index: Integer; Value: TGlb_Bairro);
begin
  inherited SetItem(Index, Value);
end;

end.