unit uGlbLogradouro;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGlb_Logradouro = class;
  TGlb_LogradouroClass = class of TGlb_Logradouro;

  TGlb_LogradouroList = class;
  TGlb_LogradouroListClass = class of TGlb_LogradouroList;

  TGlb_Logradouro = class(TmCollectionItem)
  private
    fCd_Cep: String;
    fU_Version: String;
    fCd_Municipio: String;
    fCd_Tplogradouro: String;
    fCd_Bairro: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Logradouro: String;
    fNm_Complemento: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cep : String read fCd_Cep write SetCd_Cep;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Municipio : String read fCd_Municipio write SetCd_Municipio;
    property Cd_Tplogradouro : String read fCd_Tplogradouro write SetCd_Tplogradouro;
    property Cd_Bairro : String read fCd_Bairro write SetCd_Bairro;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write SetNm_Logradouro;
    property Nm_Complemento : String read fNm_Complemento write SetNm_Complemento;
  end;

  TGlb_LogradouroList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGlb_Logradouro;
    procedure SetItem(Index: Integer; Value: TGlb_Logradouro);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGlb_Logradouro;
    property Items[Index: Integer]: TGlb_Logradouro read GetItem write SetItem; default;
  end;

implementation

{ TGlb_Logradouro }

constructor TGlb_Logradouro.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGlb_Logradouro.Destroy;
begin

  inherited;
end;

{ TGlb_LogradouroList }

constructor TGlb_LogradouroList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGlb_Logradouro);
end;

function TGlb_LogradouroList.Add: TGlb_Logradouro;
begin
  Result := TGlb_Logradouro(inherited Add);
  Result.create;
end;

function TGlb_LogradouroList.GetItem(Index: Integer): TGlb_Logradouro;
begin
  Result := TGlb_Logradouro(inherited GetItem(Index));
end;

procedure TGlb_LogradouroList.SetItem(Index: Integer; Value: TGlb_Logradouro);
begin
  inherited SetItem(Index, Value);
end;

end.