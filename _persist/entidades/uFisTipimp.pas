unit uFisTipimp;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Tipimp = class;
  TFis_TipimpClass = class of TFis_Tipimp;

  TFis_TipimpList = class;
  TFis_TipimpListClass = class of TFis_TipimpList;

  TFis_Tipimp = class(TcCollectionItem)
  private
    fCd_Tipi: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Importacao: Real;
    fPr_Pis: Real;
    fPr_Confins: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipi : String read fCd_Tipi write fCd_Tipi;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Importacao : Real read fPr_Importacao write fPr_Importacao;
    property Pr_Pis : Real read fPr_Pis write fPr_Pis;
    property Pr_Confins : Real read fPr_Confins write fPr_Confins;
  end;

  TFis_TipimpList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Tipimp;
    procedure SetItem(Index: Integer; Value: TFis_Tipimp);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Tipimp;
    property Items[Index: Integer]: TFis_Tipimp read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Tipimp }

constructor TFis_Tipimp.Create;
begin

end;

destructor TFis_Tipimp.Destroy;
begin

  inherited;
end;

{ TFis_TipimpList }

constructor TFis_TipimpList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Tipimp);
end;

function TFis_TipimpList.Add: TFis_Tipimp;
begin
  Result := TFis_Tipimp(inherited Add);
  Result.create;
end;

function TFis_TipimpList.GetItem(Index: Integer): TFis_Tipimp;
begin
  Result := TFis_Tipimp(inherited GetItem(Index));
end;

procedure TFis_TipimpList.SetItem(Index: Integer; Value: TFis_Tipimp);
begin
  inherited SetItem(Index, Value);
end;

end.