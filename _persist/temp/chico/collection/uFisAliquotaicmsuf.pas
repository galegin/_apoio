unit uFisAliquotaicmsuf;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Aliquotaicmsuf = class;
  TFis_AliquotaicmsufClass = class of TFis_Aliquotaicmsuf;

  TFis_AliquotaicmsufList = class;
  TFis_AliquotaicmsufListClass = class of TFis_AliquotaicmsufList;

  TFis_Aliquotaicmsuf = class(TmCollectionItem)
  private
    fCd_Uforigem: String;
    fCd_Ufdestino: String;
    fU_Version: String;
    fPr_Aliqicms: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Uforigem : String read fCd_Uforigem write SetCd_Uforigem;
    property Cd_Ufdestino : String read fCd_Ufdestino write SetCd_Ufdestino;
    property U_Version : String read fU_Version write SetU_Version;
    property Pr_Aliqicms : String read fPr_Aliqicms write SetPr_Aliqicms;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TFis_AliquotaicmsufList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Aliquotaicmsuf;
    procedure SetItem(Index: Integer; Value: TFis_Aliquotaicmsuf);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Aliquotaicmsuf;
    property Items[Index: Integer]: TFis_Aliquotaicmsuf read GetItem write SetItem; default;
  end;

implementation

{ TFis_Aliquotaicmsuf }

constructor TFis_Aliquotaicmsuf.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Aliquotaicmsuf.Destroy;
begin

  inherited;
end;

{ TFis_AliquotaicmsufList }

constructor TFis_AliquotaicmsufList.Create(AOwner: TPersistentCollection);
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