unit uFgrPortempresa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Portempresa = class;
  TFgr_PortempresaClass = class of TFgr_Portempresa;

  TFgr_PortempresaList = class;
  TFgr_PortempresaListClass = class of TFgr_PortempresaList;

  TFgr_Portempresa = class(TcCollectionItem)
  private
    fNr_Portador: Real;
    fCd_Empresa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Formulacartao: Real;
    fCd_Pessoa: Real;
    fNr_Estabelecimento: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Formulacartao : Real read fCd_Formulacartao write fCd_Formulacartao;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Estabelecimento : Real read fNr_Estabelecimento write fNr_Estabelecimento;
  end;

  TFgr_PortempresaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Portempresa;
    procedure SetItem(Index: Integer; Value: TFgr_Portempresa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Portempresa;
    property Items[Index: Integer]: TFgr_Portempresa read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Portempresa }

constructor TFgr_Portempresa.Create;
begin

end;

destructor TFgr_Portempresa.Destroy;
begin

  inherited;
end;

{ TFgr_PortempresaList }

constructor TFgr_PortempresaList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Portempresa);
end;

function TFgr_PortempresaList.Add: TFgr_Portempresa;
begin
  Result := TFgr_Portempresa(inherited Add);
  Result.create;
end;

function TFgr_PortempresaList.GetItem(Index: Integer): TFgr_Portempresa;
begin
  Result := TFgr_Portempresa(inherited GetItem(Index));
end;

procedure TFgr_PortempresaList.SetItem(Index: Integer; Value: TFgr_Portempresa);
begin
  inherited SetItem(Index, Value);
end;

end.