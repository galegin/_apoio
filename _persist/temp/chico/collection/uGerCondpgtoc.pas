unit uGerCondpgtoc;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Condpgtoc = class;
  TGer_CondpgtocClass = class of TGer_Condpgtoc;

  TGer_CondpgtocList = class;
  TGer_CondpgtocListClass = class of TGer_CondpgtocList;

  TGer_Condpgtoc = class(TmCollectionItem)
  private
    fCd_Condpgto: String;
    fU_Version: String;
    fNr_Parcelas: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Condpgto: String;
    fIn_Bloqueio: String;
    fPr_Desconto: String;
    fPr_Juro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Condpgto : String read fCd_Condpgto write SetCd_Condpgto;
    property U_Version : String read fU_Version write SetU_Version;
    property Nr_Parcelas : String read fNr_Parcelas write SetNr_Parcelas;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Condpgto : String read fDs_Condpgto write SetDs_Condpgto;
    property In_Bloqueio : String read fIn_Bloqueio write SetIn_Bloqueio;
    property Pr_Desconto : String read fPr_Desconto write SetPr_Desconto;
    property Pr_Juro : String read fPr_Juro write SetPr_Juro;
  end;

  TGer_CondpgtocList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoc;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoc);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Condpgtoc;
    property Items[Index: Integer]: TGer_Condpgtoc read GetItem write SetItem; default;
  end;

implementation

{ TGer_Condpgtoc }

constructor TGer_Condpgtoc.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Condpgtoc.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtocList }

constructor TGer_CondpgtocList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Condpgtoc);
end;

function TGer_CondpgtocList.Add: TGer_Condpgtoc;
begin
  Result := TGer_Condpgtoc(inherited Add);
  Result.create;
end;

function TGer_CondpgtocList.GetItem(Index: Integer): TGer_Condpgtoc;
begin
  Result := TGer_Condpgtoc(inherited GetItem(Index));
end;

procedure TGer_CondpgtocList.SetItem(Index: Integer; Value: TGer_Condpgtoc);
begin
  inherited SetItem(Index, Value);
end;

end.