unit uFisRetornonfe;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TFis_Retornonfe = class;
  TFis_RetornonfeClass = class of TFis_Retornonfe;

  TFis_RetornonfeList = class;
  TFis_RetornonfeListClass = class of TFis_RetornonfeList;

  TFis_Retornonfe = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Pedido: String;
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
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Pedido : String read fTp_Pedido write SetTp_Pedido;
    property Tp_Ambiente : String read fTp_Ambiente write SetTp_Ambiente;
    property Tp_Emissao : String read fTp_Emissao write SetTp_Emissao;
    property Ds_Envioxml : String read fDs_Envioxml write SetDs_Envioxml;
    property Ds_Retornoxml : String read fDs_Retornoxml write SetDs_Retornoxml;
  end;

  TFis_RetornonfeList = class(TmCollection)
  private
    function GetItem(Index: Integer): TFis_Retornonfe;
    procedure SetItem(Index: Integer; Value: TFis_Retornonfe);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TFis_Retornonfe;
    property Items[Index: Integer]: TFis_Retornonfe read GetItem write SetItem; default;
  end;

implementation

{ TFis_Retornonfe }

constructor TFis_Retornonfe.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TFis_Retornonfe.Destroy;
begin

  inherited;
end;

{ TFis_RetornonfeList }

constructor TFis_RetornonfeList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TFis_Retornonfe);
end;

function TFis_RetornonfeList.Add: TFis_Retornonfe;
begin
  Result := TFis_Retornonfe(inherited Add);
  Result.create;
end;

function TFis_RetornonfeList.GetItem(Index: Integer): TFis_Retornonfe;
begin
  Result := TFis_Retornonfe(inherited GetItem(Index));
end;

procedure TFis_RetornonfeList.SetItem(Index: Integer; Value: TFis_Retornonfe);
begin
  inherited SetItem(Index, Value);
end;

end.