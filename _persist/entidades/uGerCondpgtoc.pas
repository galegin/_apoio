unit uGerCondpgtoc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Condpgtoc = class;
  TGer_CondpgtocClass = class of TGer_Condpgtoc;

  TGer_CondpgtocList = class;
  TGer_CondpgtocListClass = class of TGer_CondpgtocList;

  TGer_Condpgtoc = class(TcCollectionItem)
  private
    fCd_Condpgto: Real;
    fU_Version: String;
    fNr_Parcelas: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Condpgto: String;
    fIn_Bloqueio: String;
    fPr_Desconto: Real;
    fPr_Juro: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Parcelas : Real read fNr_Parcelas write fNr_Parcelas;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Condpgto : String read fDs_Condpgto write fDs_Condpgto;
    property In_Bloqueio : String read fIn_Bloqueio write fIn_Bloqueio;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Pr_Juro : Real read fPr_Juro write fPr_Juro;
  end;

  TGer_CondpgtocList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoc;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Condpgtoc;
    property Items[Index: Integer]: TGer_Condpgtoc read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Condpgtoc }

constructor TGer_Condpgtoc.Create;
begin

end;

destructor TGer_Condpgtoc.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtocList }

constructor TGer_CondpgtocList.Create(AOwner: TPersistent);
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