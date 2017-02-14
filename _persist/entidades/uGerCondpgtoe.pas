unit uGerCondpgtoe;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Condpgtoe = class;
  TGer_CondpgtoeClass = class of TGer_Condpgtoe;

  TGer_CondpgtoeList = class;
  TGer_CondpgtoeListClass = class of TGer_CondpgtoeList;

  TGer_Condpgtoe = class(TcCollectionItem)
  private
    fCd_Condpgto: Real;
    fNr_Seq4: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Diainicial: Real;
    fNr_Diafinal: Real;
    fNr_Diavencimento: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Nr_Seq4 : Real read fNr_Seq4 write fNr_Seq4;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Diainicial : Real read fNr_Diainicial write fNr_Diainicial;
    property Nr_Diafinal : Real read fNr_Diafinal write fNr_Diafinal;
    property Nr_Diavencimento : Real read fNr_Diavencimento write fNr_Diavencimento;
  end;

  TGer_CondpgtoeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoe;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoe);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Condpgtoe;
    property Items[Index: Integer]: TGer_Condpgtoe read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Condpgtoe }

constructor TGer_Condpgtoe.Create;
begin

end;

destructor TGer_Condpgtoe.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtoeList }

constructor TGer_CondpgtoeList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Condpgtoe);
end;

function TGer_CondpgtoeList.Add: TGer_Condpgtoe;
begin
  Result := TGer_Condpgtoe(inherited Add);
  Result.create;
end;

function TGer_CondpgtoeList.GetItem(Index: Integer): TGer_Condpgtoe;
begin
  Result := TGer_Condpgtoe(inherited GetItem(Index));
end;

procedure TGer_CondpgtoeList.SetItem(Index: Integer; Value: TGer_Condpgtoe);
begin
  inherited SetItem(Index, Value);
end;

end.