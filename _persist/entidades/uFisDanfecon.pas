unit uFisDanfecon;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Danfecon = class;
  TFis_DanfeconClass = class of TFis_Danfecon;

  TFis_DanfeconList = class;
  TFis_DanfeconListClass = class of TFis_DanfeconList;

  TFis_Danfecon = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Seqcon: Real;
    fU_Version: String;
    fCd_Operador: Integer;
    fDt_Cadastro: TDateTime;
    fCd_Conteudo: Real;
    fTp_Banda: String;
    fNr_Pagina: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Seqcon : Real read fNr_Seqcon write fNr_Seqcon;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Integer read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Conteudo : Real read fCd_Conteudo write fCd_Conteudo;
    property Tp_Banda : String read fTp_Banda write fTp_Banda;
    property Nr_Pagina : Real read fNr_Pagina write fNr_Pagina;
  end;

  TFis_DanfeconList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Danfecon;
    procedure SetItem(Index: Integer; Value: TFis_Danfecon);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Danfecon;
    property Items[Index: Integer]: TFis_Danfecon read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Danfecon }

constructor TFis_Danfecon.Create;
begin

end;

destructor TFis_Danfecon.Destroy;
begin

  inherited;
end;

{ TFis_DanfeconList }

constructor TFis_DanfeconList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Danfecon);
end;

function TFis_DanfeconList.Add: TFis_Danfecon;
begin
  Result := TFis_Danfecon(inherited Add);
  Result.create;
end;

function TFis_DanfeconList.GetItem(Index: Integer): TFis_Danfecon;
begin
  Result := TFis_Danfecon(inherited GetItem(Index));
end;

procedure TFis_DanfeconList.SetItem(Index: Integer; Value: TFis_Danfecon);
begin
  inherited SetItem(Index, Value);
end;

end.