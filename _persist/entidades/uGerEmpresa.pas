unit uGerEmpresa;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Empresa = class;
  TGer_EmpresaClass = class of TGer_Empresa;

  TGer_EmpresaList = class;
  TGer_EmpresaListClass = class of TGer_EmpresaList;

  TGer_Empresa = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fCd_Pessoa: Real;
    fDt_Cadastro: TDateTime;
    fCd_Ccusto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Ccusto : Real read fCd_Ccusto write fCd_Ccusto;
  end;

  TGer_EmpresaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Empresa;
    procedure SetItem(Index: Integer; Value: TGer_Empresa);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Empresa;
    property Items[Index: Integer]: TGer_Empresa read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Empresa }

constructor TGer_Empresa.Create;
begin

end;

destructor TGer_Empresa.Destroy;
begin

  inherited;
end;

{ TGer_EmpresaList }

constructor TGer_EmpresaList.Create(AOwner: TPersistent);
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