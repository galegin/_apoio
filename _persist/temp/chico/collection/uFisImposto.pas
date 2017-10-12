unit uFisImposto;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Imposto = class;
  TFis_ImpostoClass = class of TFis_Imposto;

  TFis_ImpostoList = class;
  TFis_ImpostoListClass = class of TFis_ImpostoList;

  TFis_Imposto = class(TmCollectionItem)
  private
    fCd_Imposto: String;
    fDt_Inivigencia: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Aliquota: String;
    fTp_Situacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Imposto : String read fCd_Imposto write SetCd_Imposto;
    property Dt_Inivigencia : String read fDt_Inivigencia write SetDt_Inivigencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Aliquota : String read fPr_Aliquota write SetPr_Aliquota;
    property Tp_Situacao : String read fTp_Situacao write SetTp_Situacao;
  end;

  TFis_ImpostoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Imposto;
    procedure SetItem(Index: Integer; Value: TFis_Imposto);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Imposto;
    property Items[Index: Integer]: TFis_Imposto read GetItem write SetItem; default;
  end;

implementation

{ TFis_Imposto }

constructor TFis_Imposto.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Imposto.Destroy;
begin

  inherited;
end;

{ TFis_ImpostoList }

constructor TFis_ImpostoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Imposto);
end;

function TFis_ImpostoList.Add: TFis_Imposto;
begin
  Result := TFis_Imposto(inherited Add);
  Result.create;
end;

function TFis_ImpostoList.GetItem(Index: Integer): TFis_Imposto;
begin
  Result := TFis_Imposto(inherited GetItem(Index));
end;

procedure TFis_ImpostoList.SetItem(Index: Integer; Value: TFis_Imposto);
begin
  inherited SetItem(Index, Value);
end;

end.