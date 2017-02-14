unit uGlbLogradouro;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Logradouro = class;
  TGlb_LogradouroClass = class of TGlb_Logradouro;

  TGlb_LogradouroList = class;
  TGlb_LogradouroListClass = class of TGlb_LogradouroList;

  TGlb_Logradouro = class(TcCollectionItem)
  private
    fCd_Cep: String;
    fU_Version: String;
    fCd_Municipio: Real;
    fCd_Tplogradouro: Real;
    fCd_Bairro: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Logradouro: String;
    fNm_Complemento: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cep : String read fCd_Cep write fCd_Cep;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Municipio : Real read fCd_Municipio write fCd_Municipio;
    property Cd_Tplogradouro : Real read fCd_Tplogradouro write fCd_Tplogradouro;
    property Cd_Bairro : Real read fCd_Bairro write fCd_Bairro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Logradouro : String read fNm_Logradouro write fNm_Logradouro;
    property Nm_Complemento : String read fNm_Complemento write fNm_Complemento;
  end;

  TGlb_LogradouroList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Logradouro;
    procedure SetItem(Index: Integer; Value: TGlb_Logradouro);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Logradouro;
    property Items[Index: Integer]: TGlb_Logradouro read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Logradouro }

constructor TGlb_Logradouro.Create;
begin

end;

destructor TGlb_Logradouro.Destroy;
begin

  inherited;
end;

{ TGlb_LogradouroList }

constructor TGlb_LogradouroList.Create(AOwner: TPersistent);
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