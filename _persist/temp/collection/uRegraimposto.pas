unit uRegraimposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TRegraimposto = class;
  TRegraimpostoClass = class of TRegraimposto;

  TRegraimpostoList = class;
  TRegraimpostoListClass = class of TRegraimpostoList;

  TRegraimposto = class(TmCollectionItem)
  private
    fId_Regrafiscal: Integer;
    fCd_Imposto: Integer;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fPr_Basecalculo: String;
    fCd_Cst: String;
    fCd_Csosn: String;
    fIn_Isento: String;
    fIn_Outro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Id_Regrafiscal : Integer read fId_Regrafiscal write SetId_Regrafiscal;
    property Cd_Imposto : Integer read fCd_Imposto write SetCd_Imposto;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Pr_Basecalculo : String read fPr_Basecalculo write SetPr_Basecalculo;
    property Cd_Cst : String read fCd_Cst write SetCd_Cst;
    property Cd_Csosn : String read fCd_Csosn write SetCd_Csosn;
    property In_Isento : String read fIn_Isento write SetIn_Isento;
    property In_Outro : String read fIn_Outro write SetIn_Outro;
  end;

  TRegraimpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TRegraimposto;
    procedure SetItem(Index: Integer; Value: TRegraimposto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TRegraimposto;
    property Items[Index: Integer]: TRegraimposto read GetItem write SetItem; default;
  end;

implementation

{ TRegraimposto }

constructor TRegraimposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TRegraimposto.Destroy;
begin

  inherited;
end;

{ TRegraimpostoList }

constructor TRegraimpostoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TRegraimposto);
end;

function TRegraimpostoList.Add: TRegraimposto;
begin
  Result := TRegraimposto(inherited Add);
  Result.create;
end;

function TRegraimpostoList.GetItem(Index: Integer): TRegraimposto;
begin
  Result := TRegraimposto(inherited GetItem(Index));
end;

procedure TRegraimpostoList.SetItem(Index: Integer; Value: TRegraimposto);
begin
  inherited SetItem(Index, Value);
end;

end.