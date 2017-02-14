unit uAdmParametro;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TAdm_Parametro = class;
  TAdm_ParametroClass = class of TAdm_Parametro;

  TAdm_ParametroList = class;
  TAdm_ParametroListClass = class of TAdm_ParametroList;

  TAdm_Parametro = class(TcCollectionItem)
  private
    fCd_Parametro: String;
    fU_Version: String;
    fTp_Parametro: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Parametro: String;
    fIn_Manutencao: String;
    fIn_Param: String;
    fNr_Nivel: Real;
    fCd_Parampai: String;
    fNm_Svcvld: String;
    fNm_Opervld: String;
    fVl_Parametro: String;
    fDs_Mascara: String;
    fCd_Manutencao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Parametro : String read fCd_Parametro write fCd_Parametro;
    property U_Version : String read fU_Version write fU_Version;
    property Tp_Parametro : Real read fTp_Parametro write fTp_Parametro;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Parametro : String read fNm_Parametro write fNm_Parametro;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property In_Param : String read fIn_Param write fIn_Param;
    property Nr_Nivel : Real read fNr_Nivel write fNr_Nivel;
    property Cd_Parampai : String read fCd_Parampai write fCd_Parampai;
    property Nm_Svcvld : String read fNm_Svcvld write fNm_Svcvld;
    property Nm_Opervld : String read fNm_Opervld write fNm_Opervld;
    property Vl_Parametro : String read fVl_Parametro write fVl_Parametro;
    property Ds_Mascara : String read fDs_Mascara write fDs_Mascara;
    property Cd_Manutencao : String read fCd_Manutencao write fCd_Manutencao;
  end;

  TAdm_ParametroList = class(TcCollection)
  private
    function GetItem(Index: Integer): TAdm_Parametro;
    procedure SetItem(Index: Integer; Value: TAdm_Parametro);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TAdm_Parametro;
    property Items[Index: Integer]: TAdm_Parametro read GetItem write SetItem; default;
  end;
  
implementation

{ TAdm_Parametro }

constructor TAdm_Parametro.Create;
begin

end;

destructor TAdm_Parametro.Destroy;
begin

  inherited;
end;

{ TAdm_ParametroList }

constructor TAdm_ParametroList.Create(AOwner: TPersistent);
begin
  inherited Create(TAdm_Parametro);
end;

function TAdm_ParametroList.Add: TAdm_Parametro;
begin
  Result := TAdm_Parametro(inherited Add);
  Result.create;
end;

function TAdm_ParametroList.GetItem(Index: Integer): TAdm_Parametro;
begin
  Result := TAdm_Parametro(inherited GetItem(Index));
end;

procedure TAdm_ParametroList.SetItem(Index: Integer; Value: TAdm_Parametro);
begin
  inherited SetItem(Index, Value);
end;

end.