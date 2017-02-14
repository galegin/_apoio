unit uGerCondpgtoi;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Condpgtoi = class;
  TGer_CondpgtoiClass = class of TGer_Condpgtoi;

  TGer_CondpgtoiList = class;
  TGer_CondpgtoiListClass = class of TGer_CondpgtoiList;

  TGer_Condpgtoi = class(TcCollectionItem)
  private
    fCd_Condpgto: Real;
    fNr_Seq4: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fQt_Dia: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Nr_Seq4 : Real read fNr_Seq4 write fNr_Seq4;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Qt_Dia : Real read fQt_Dia write fQt_Dia;
  end;

  TGer_CondpgtoiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoi;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoi);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Condpgtoi;
    property Items[Index: Integer]: TGer_Condpgtoi read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Condpgtoi }

constructor TGer_Condpgtoi.Create;
begin

end;

destructor TGer_Condpgtoi.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtoiList }

constructor TGer_CondpgtoiList.Create(AOwner: TPersistent);
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