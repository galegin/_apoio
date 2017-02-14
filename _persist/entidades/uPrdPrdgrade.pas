unit uPrdPrdgrade;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdgrade = class;
  TPrd_PrdgradeClass = class of TPrd_Prdgrade;

  TPrd_PrdgradeList = class;
  TPrd_PrdgradeListClass = class of TPrd_PrdgradeList;

  TPrd_Prdgrade = class(TcCollectionItem)
  private
    fCd_Seqgrupo: Real;
    fCd_Cor: String;
    fCd_Tamanho: Real;
    fU_Version: String;
    fCd_Produto: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Seqgrupo : Real read fCd_Seqgrupo write fCd_Seqgrupo;
    property Cd_Cor : String read fCd_Cor write fCd_Cor;
    property Cd_Tamanho : Real read fCd_Tamanho write fCd_Tamanho;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_PrdgradeList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdgrade;
    procedure SetItem(Index: Integer; Value: TPrd_Prdgrade);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdgrade;
    property Items[Index: Integer]: TPrd_Prdgrade read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdgrade }

constructor TPrd_Prdgrade.Create;
begin

end;

destructor TPrd_Prdgrade.Destroy;
begin

  inherited;
end;

{ TPrd_PrdgradeList }

constructor TPrd_PrdgradeList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Prdgrade);
end;

function TPrd_PrdgradeList.Add: TPrd_Prdgrade;
begin
  Result := TPrd_Prdgrade(inherited Add);
  Result.create;
end;

function TPrd_PrdgradeList.GetItem(Index: Integer): TPrd_Prdgrade;
begin
  Result := TPrd_Prdgrade(inherited GetItem(Index));
end;

procedure TPrd_PrdgradeList.SetItem(Index: Integer; Value: TPrd_Prdgrade);
begin
  inherited SetItem(Index, Value);
end;

end.