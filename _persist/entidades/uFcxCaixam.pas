unit uFcxCaixam;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcx_Caixam = class;
  TFcx_CaixamClass = class of TFcx_Caixam;

  TFcx_CaixamList = class;
  TFcx_CaixamListClass = class of TFcx_CaixamList;

  TFcx_Caixam = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fDt_Abertura: TDateTime;
    fNr_Seq: Real;
    fNr_Ctapes: Real;
    fDt_Movim: TDateTime;
    fNr_Seqmov: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property Dt_Abertura : TDateTime read fDt_Abertura write fDt_Abertura;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : TDateTime read fDt_Movim write fDt_Movim;
    property Nr_Seqmov : Real read fNr_Seqmov write fNr_Seqmov;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFcx_CaixamList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixam;
    procedure SetItem(Index: Integer; Value: TFcx_Caixam);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcx_Caixam;
    property Items[Index: Integer]: TFcx_Caixam read GetItem write SetItem; default;
  end;
  
implementation

{ TFcx_Caixam }

constructor TFcx_Caixam.Create;
begin

end;

destructor TFcx_Caixam.Destroy;
begin

  inherited;
end;

{ TFcx_CaixamList }

constructor TFcx_CaixamList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcx_Caixam);
end;

function TFcx_CaixamList.Add: TFcx_Caixam;
begin
  Result := TFcx_Caixam(inherited Add);
  Result.create;
end;

function TFcx_CaixamList.GetItem(Index: Integer): TFcx_Caixam;
begin
  Result := TFcx_Caixam(inherited GetItem(Index));
end;

procedure TFcx_CaixamList.SetItem(Index: Integer; Value: TFcx_Caixam);
begin
  inherited SetItem(Index, Value);
end;

end.