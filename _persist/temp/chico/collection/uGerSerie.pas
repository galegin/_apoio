unit uGerSerie;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Serie = class;
  TGer_SerieClass = class of TGer_Serie;

  TGer_SerieList = class;
  TGer_SerieListClass = class of TGer_SerieList;

  TGer_Serie = class(TmCollectionItem)
  private
    fCd_Serie: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Serie: String;
    fDs_Sigla: String;
    fTp_Operacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Serie : String read fDs_Serie write SetDs_Serie;
    property Ds_Sigla : String read fDs_Sigla write SetDs_Sigla;
    property Tp_Operacao : String read fTp_Operacao write SetTp_Operacao;
  end;

  TGer_SerieList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Serie;
    procedure SetItem(Index: Integer; Value: TGer_Serie);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Serie;
    property Items[Index: Integer]: TGer_Serie read GetItem write SetItem; default;
  end;

implementation

{ TGer_Serie }

constructor TGer_Serie.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Serie.Destroy;
begin

  inherited;
end;

{ TGer_SerieList }

constructor TGer_SerieList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Serie);
end;

function TGer_SerieList.Add: TGer_Serie;
begin
  Result := TGer_Serie(inherited Add);
  Result.create;
end;

function TGer_SerieList.GetItem(Index: Integer): TGer_Serie;
begin
  Result := TGer_Serie(inherited GetItem(Index));
end;

procedure TGer_SerieList.SetItem(Index: Integer; Value: TGer_Serie);
begin
  inherited SetItem(Index, Value);
end;

end.