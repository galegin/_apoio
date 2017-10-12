unit uFisNfexml;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Nfexml = class;
  TFis_NfexmlClass = class of TFis_Nfexml;

  TFis_NfexmlList = class;
  TFis_NfexmlListClass = class of TFis_NfexmlList;

  TFis_Nfexml = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Ambiente: String;
    fTp_Emissao: String;
    fDs_Envioxml: String;
    fDs_Retornoxml: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Ambiente : String read fTp_Ambiente write SetTp_Ambiente;
    property Tp_Emissao : String read fTp_Emissao write SetTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write SetDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write SetDs_Retornoxml;
  end;

  TFis_NfexmlList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Nfexml;
    procedure SetItem(Index: Integer; Value: TFis_Nfexml);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Nfexml;
    property Items[Index: Integer]: TFis_Nfexml read GetItem write SetItem; default;
  end;

implementation

{ TFis_Nfexml }

constructor TFis_Nfexml.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Nfexml.Destroy;
begin

  inherited;
end;

{ TFis_NfexmlList }

constructor TFis_NfexmlList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Nfexml);
end;

function TFis_NfexmlList.Add: TFis_Nfexml;
begin
  Result := TFis_Nfexml(inherited Add);
  Result.create;
end;

function TFis_NfexmlList.GetItem(Index: Integer): TFis_Nfexml;
begin
  Result := TFis_Nfexml(inherited GetItem(Index));
end;

procedure TFis_NfexmlList.SetItem(Index: Integer; Value: TFis_Nfexml);
begin
  inherited SetItem(Index, Value);
end;

end.