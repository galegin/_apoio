unit uPrdPrdgrade;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Prdgrade = class;
  TPrd_PrdgradeClass = class of TPrd_Prdgrade;

  TPrd_PrdgradeList = class;
  TPrd_PrdgradeListClass = class of TPrd_PrdgradeList;

  TPrd_Prdgrade = class(TmCollectionItem)
  private
    fCd_Seqgrupo: String;
    fCd_Cor: String;
    fCd_Tamanho: String;
    fU_Version: String;
    fCd_Produto: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Seqgrupo : String read fCd_Seqgrupo write SetCd_Seqgrupo;
    property Cd_Cor : String read fCd_Cor write SetCd_Cor;
    property Cd_Tamanho : String read fCd_Tamanho write SetCd_Tamanho;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TPrd_PrdgradeList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdgrade;
    procedure SetItem(Index: Integer; Value: TPrd_Prdgrade);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Prdgrade;
    property Items[Index: Integer]: TPrd_Prdgrade read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Prdgrade }

constructor TPrd_Prdgrade.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Prdgrade.Destroy;
begin

  inherited;
end;

{ TPrd_PrdgradeList }

constructor TPrd_PrdgradeList.Create(AOwner: TPersistentCollection);
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