unit uGerEmpresa;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Empresa = class;
  TGer_EmpresaClass = class of TGer_Empresa;

  TGer_EmpresaList = class;
  TGer_EmpresaListClass = class of TGer_EmpresaList;

  TGer_Empresa = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fU_Version: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fCd_Pessoa: String;
    fDt_Cadastro: String;
    fCd_Ccusto: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Cd_Ccusto : String read fCd_Ccusto write SetCd_Ccusto;
  end;

  TGer_EmpresaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Empresa;
    procedure SetItem(Index: Integer; Value: TGer_Empresa);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Empresa;
    property Items[Index: Integer]: TGer_Empresa read GetItem write SetItem; default;
  end;

implementation

{ TGer_Empresa }

constructor TGer_Empresa.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Empresa.Destroy;
begin

  inherited;
end;

{ TGer_EmpresaList }

constructor TGer_EmpresaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Empresa);
end;

function TGer_EmpresaList.Add: TGer_Empresa;
begin
  Result := TGer_Empresa(inherited Add);
  Result.create;
end;

function TGer_EmpresaList.GetItem(Index: Integer): TGer_Empresa;
begin
  Result := TGer_Empresa(inherited GetItem(Index));
end;

procedure TGer_EmpresaList.SetItem(Index: Integer; Value: TGer_Empresa);
begin
  inherited SetItem(Index, Value);
end;

end.