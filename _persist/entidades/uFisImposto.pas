unit uFisImposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Imposto = class;
  TFis_ImpostoClass = class of TFis_Imposto;

  TFis_ImpostoList = class;
  TFis_ImpostoListClass = class of TFis_ImpostoList;

  TFis_Imposto = class(TcCollectionItem)
  private
    fCd_Imposto: Real;
    fDt_Inivigencia: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fTp_Situacao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property Dt_Inivigencia : TDateTime read fDt_Inivigencia write fDt_Inivigencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
  end;

  TFis_ImpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Imposto;
    procedure SetItem(Index: Integer; Value: TFis_Imposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Imposto;
    property Items[Index: Integer]: TFis_Imposto read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Imposto }

constructor TFis_Imposto.Create;
begin

end;

destructor TFis_Imposto.Destroy;
begin

  inherited;
end;

{ TFis_ImpostoList }

constructor TFis_ImpostoList.Create(AOwner: TPersistent);
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