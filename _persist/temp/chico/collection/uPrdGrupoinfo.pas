unit uPrdGrupoinfo;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Grupoinfo = class;
  TPrd_GrupoinfoClass = class of TPrd_Grupoinfo;

  TPrd_GrupoinfoList = class;
  TPrd_GrupoinfoListClass = class of TPrd_GrupoinfoList;

  TPrd_Grupoinfo = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Seqgrupo: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Markup: String;
    fPr_Comissao: String;
    fIn_Prodpropria: String;
    fIn_Inativo: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fIn_Matconsumo: String;
    fIn_Patrimonio: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Seqgrupo : String read fCd_Seqgrupo write SetCd_Seqgrupo;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Pr_Markup : String read fPr_Markup write SetPr_Markup;
    property Pr_Comissao : String read fPr_Comissao write SetPr_Comissao;
    property In_Prodpropria : String read fIn_Prodpropria write SetIn_Prodpropria;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write SetIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write SetIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write SetIn_Matconsumo;
    property In_Patrimonio : String read fIn_Patrimonio write SetIn_Patrimonio;
  end;

  TPrd_GrupoinfoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupoinfo;
    procedure SetItem(Index: Integer; Value: TPrd_Grupoinfo);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Grupoinfo;
    property Items[Index: Integer]: TPrd_Grupoinfo read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Grupoinfo }

constructor TPrd_Grupoinfo.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Grupoinfo.Destroy;
begin

  inherited;
end;

{ TPrd_GrupoinfoList }

constructor TPrd_GrupoinfoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Grupoinfo);
end;

function TPrd_GrupoinfoList.Add: TPrd_Grupoinfo;
begin
  Result := TPrd_Grupoinfo(inherited Add);
  Result.create;
end;

function TPrd_GrupoinfoList.GetItem(Index: Integer): TPrd_Grupoinfo;
begin
  Result := TPrd_Grupoinfo(inherited GetItem(Index));
end;

procedure TPrd_GrupoinfoList.SetItem(Index: Integer; Value: TPrd_Grupoinfo);
begin
  inherited SetItem(Index, Value);
end;

end.