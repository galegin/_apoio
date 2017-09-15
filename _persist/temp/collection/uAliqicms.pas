unit uAliqicms;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TAliqicms = class;
  TAliqicmsClass = class of TAliqicms;

  TAliqicmsList = class;
  TAliqicmsListClass = class of TAliqicmsList;

  TAliqicms = class(TmCollectionItem)
  private
    fUf_Origem: String;
    fUf_Destino: String;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Uf_Origem : String read fUf_Origem write SetUf_Origem;
    property Uf_Destino : String read fUf_Destino write SetUf_Destino;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : Integer read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
  end;

  TAliqicmsList = class(TmCollection)
  private
    function GetItem(Index: Integer): TAliqicms;
    procedure SetItem(Index: Integer; Value: TAliqicms);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TAliqicms;
    property Items[Index: Integer]: TAliqicms read GetItem write SetItem; default;
  end;

implementation

{ TAliqicms }

constructor TAliqicms.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TAliqicms.Destroy;
begin

  inherited;
end;

{ TAliqicmsList }

constructor TAliqicmsList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TAliqicms);
end;

function TAliqicmsList.Add: TAliqicms;
begin
  Result := TAliqicms(inherited Add);
  Result.create;
end;

function TAliqicmsList.GetItem(Index: Integer): TAliqicms;
begin
  Result := TAliqicms(inherited GetItem(Index));
end;

procedure TAliqicmsList.SetItem(Index: Integer; Value: TAliqicms);
begin
  inherited SetItem(Index, Value);
end;

end.