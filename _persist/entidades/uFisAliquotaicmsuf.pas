unit uFisAliquotaicmsuf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Aliquotaicmsuf = class;
  TFis_AliquotaicmsufClass = class of TFis_Aliquotaicmsuf;

  TFis_AliquotaicmsufList = class;
  TFis_AliquotaicmsufListClass = class of TFis_AliquotaicmsufList;

  TFis_Aliquotaicmsuf = class(TcCollectionItem)
  private
    fCd_Uforigem: String;
    fCd_Ufdestino: String;
    fU_Version: String;
    fPr_Aliqicms: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Uforigem : String read fCd_Uforigem write fCd_Uforigem;
    property Cd_Ufdestino : String read fCd_Ufdestino write fCd_Ufdestino;
    property U_Version : String read fU_Version write fU_Version;
    property Pr_Aliqicms : Real read fPr_Aliqicms write fPr_Aliqicms;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TFis_AliquotaicmsufList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Aliquotaicmsuf;
    procedure SetItem(Index: Integer; Value: TFis_Aliquotaicmsuf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Aliquotaicmsuf;
    property Items[Index: Integer]: TFis_Aliquotaicmsuf read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Aliquotaicmsuf }

constructor TFis_Aliquotaicmsuf.Create;
begin

end;

destructor TFis_Aliquotaicmsuf.Destroy;
begin

  inherited;
end;

{ TFis_AliquotaicmsufList }

constructor TFis_AliquotaicmsufList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Aliquotaicmsuf);
end;

function TFis_AliquotaicmsufList.Add: TFis_Aliquotaicmsuf;
begin
  Result := TFis_Aliquotaicmsuf(inherited Add);
  Result.create;
end;

function TFis_AliquotaicmsufList.GetItem(Index: Integer): TFis_Aliquotaicmsuf;
begin
  Result := TFis_Aliquotaicmsuf(inherited GetItem(Index));
end;

procedure TFis_AliquotaicmsufList.SetItem(Index: Integer; Value: TFis_Aliquotaicmsuf);
begin
  inherited SetItem(Index, Value);
end;

end.