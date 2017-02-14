unit uPrdGrupoinfo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Grupoinfo = class;
  TPrd_GrupoinfoClass = class of TPrd_Grupoinfo;

  TPrd_GrupoinfoList = class;
  TPrd_GrupoinfoListClass = class of TPrd_GrupoinfoList;

  TPrd_Grupoinfo = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Seqgrupo: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Markup: Real;
    fPr_Comissao: Real;
    fIn_Prodpropria: String;
    fIn_Inativo: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fIn_Matconsumo: String;
    fIn_Patrimonio: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Seqgrupo : Real read fCd_Seqgrupo write fCd_Seqgrupo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Markup : Real read fPr_Markup write fPr_Markup;
    property Pr_Comissao : Real read fPr_Comissao write fPr_Comissao;
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
  end;

  TPrd_GrupoinfoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Grupoinfo;
    procedure SetItem(Index: Integer; Value: TPrd_Grupoinfo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Grupoinfo;
    property Items[Index: Integer]: TPrd_Grupoinfo read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Grupoinfo }

constructor TPrd_Grupoinfo.Create;
begin

end;

destructor TPrd_Grupoinfo.Destroy;
begin

  inherited;
end;

{ TPrd_GrupoinfoList }

constructor TPrd_GrupoinfoList.Create(AOwner: TPersistent);
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