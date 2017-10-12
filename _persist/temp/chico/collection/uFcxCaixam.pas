unit uFcxCaixam;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFcx_Caixam = class;
  TFcx_CaixamClass = class of TFcx_Caixam;

  TFcx_CaixamList = class;
  TFcx_CaixamListClass = class of TFcx_CaixamList;

  TFcx_Caixam = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Terminal: String;
    fDt_Abertura: String;
    fNr_Seq: String;
    fNr_Ctapes: String;
    fDt_Movim: String;
    fNr_Seqmov: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Terminal : String read fCd_Terminal write SetCd_Terminal;
    property Dt_Abertura : String read fDt_Abertura write SetDt_Abertura;
    property Nr_Seq : String read fNr_Seq write SetNr_Seq;
    property Nr_Ctapes : String read fNr_Ctapes write SetNr_Ctapes;
    property Dt_Movim : String read fDt_Movim write SetDt_Movim;
    property Nr_Seqmov : String read fNr_Seqmov write SetNr_Seqmov;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TFcx_CaixamList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFcx_Caixam;
    procedure SetItem(Index: Integer; Value: TFcx_Caixam);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFcx_Caixam;
    property Items[Index: Integer]: TFcx_Caixam read GetItem write SetItem; default;
  end;

implementation

{ TFcx_Caixam }

constructor TFcx_Caixam.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFcx_Caixam.Destroy;
begin

  inherited;
end;

{ TFcx_CaixamList }

constructor TFcx_CaixamList.Create(AOwner: TPersistentCollection);
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