unit uGerCondpgtoi;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Condpgtoi = class;
  TGer_CondpgtoiClass = class of TGer_Condpgtoi;

  TGer_CondpgtoiList = class;
  TGer_CondpgtoiListClass = class of TGer_CondpgtoiList;

  TGer_Condpgtoi = class(TmCollectionItem)
  private
    fCd_Condpgto: String;
    fNr_Seq4: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fQt_Dia: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Condpgto : String read fCd_Condpgto write SetCd_Condpgto;
    property Nr_Seq4 : String read fNr_Seq4 write SetNr_Seq4;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Qt_Dia : String read fQt_Dia write SetQt_Dia;
  end;

  TGer_CondpgtoiList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoi;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoi);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Condpgtoi;
    property Items[Index: Integer]: TGer_Condpgtoi read GetItem write SetItem; default;
  end;

implementation

{ TGer_Condpgtoi }

constructor TGer_Condpgtoi.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Condpgtoi.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtoiList }

constructor TGer_CondpgtoiList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Condpgtoi);
end;

function TGer_CondpgtoiList.Add: TGer_Condpgtoi;
begin
  Result := TGer_Condpgtoi(inherited Add);
  Result.create;
end;

function TGer_CondpgtoiList.GetItem(Index: Integer): TGer_Condpgtoi;
begin
  Result := TGer_Condpgtoi(inherited GetItem(Index));
end;

procedure TGer_CondpgtoiList.SetItem(Index: Integer; Value: TGer_Condpgtoi);
begin
  inherited SetItem(Index, Value);
end;

end.