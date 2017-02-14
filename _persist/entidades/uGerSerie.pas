unit uGerSerie;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Serie = class;
  TGer_SerieClass = class of TGer_Serie;

  TGer_SerieList = class;
  TGer_SerieListClass = class of TGer_SerieList;

  TGer_Serie = class(TcCollectionItem)
  private
    fCd_Serie: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Serie: String;
    fDs_Sigla: String;
    fTp_Operacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Serie : Real read fCd_Serie write fCd_Serie;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Serie : String read fDs_Serie write fDs_Serie;
    property Ds_Sigla : String read fDs_Sigla write fDs_Sigla;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
  end;

  TGer_SerieList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Serie;
    procedure SetItem(Index: Integer; Value: TGer_Serie);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Serie;
    property Items[Index: Integer]: TGer_Serie read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Serie }

constructor TGer_Serie.Create;
begin

end;

destructor TGer_Serie.Destroy;
begin

  inherited;
end;

{ TGer_SerieList }

constructor TGer_SerieList.Create(AOwner: TPersistent);
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