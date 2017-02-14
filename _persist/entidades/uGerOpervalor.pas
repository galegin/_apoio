unit uGerOpervalor;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Opervalor = class;
  TGer_OpervalorClass = class of TGer_Opervalor;

  TGer_OpervalorList = class;
  TGer_OpervalorListClass = class of TGer_OpervalorList;

  TGer_Opervalor = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fTp_Unidvalor: String;
    fCd_Unidvalor: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Precobase: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Tp_Unidvalor : String read fTp_Unidvalor write fTp_Unidvalor;
    property Cd_Unidvalor : Real read fCd_Unidvalor write fCd_Unidvalor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Precobase : String read fIn_Precobase write fIn_Precobase;
  end;

  TGer_OpervalorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Opervalor;
    procedure SetItem(Index: Integer; Value: TGer_Opervalor);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Opervalor;
    property Items[Index: Integer]: TGer_Opervalor read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Opervalor }

constructor TGer_Opervalor.Create;
begin

end;

destructor TGer_Opervalor.Destroy;
begin

  inherited;
end;

{ TGer_OpervalorList }

constructor TGer_OpervalorList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Opervalor);
end;

function TGer_OpervalorList.Add: TGer_Opervalor;
begin
  Result := TGer_Opervalor(inherited Add);
  Result.create;
end;

function TGer_OpervalorList.GetItem(Index: Integer): TGer_Opervalor;
begin
  Result := TGer_Opervalor(inherited GetItem(Index));
end;

procedure TGer_OpervalorList.SetItem(Index: Integer; Value: TGer_Opervalor);
begin
  inherited SetItem(Index, Value);
end;

end.