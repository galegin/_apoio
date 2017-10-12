unit uPrdPrdregrafiscal;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Prdregrafiscal = class;
  TPrd_PrdregrafiscalClass = class of TPrd_Prdregrafiscal;

  TPrd_PrdregrafiscalList = class;
  TPrd_PrdregrafiscalListClass = class of TPrd_PrdregrafiscalList;

  TPrd_Prdregrafiscal = class(TmCollectionItem)
  private
    fCd_Produto: String;
    fCd_Operacao: String;
    fU_Version: String;
    fCd_Regrafiscal: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Operacao : String read fCd_Operacao write SetCd_Operacao;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Regrafiscal : String read fCd_Regrafiscal write SetCd_Regrafiscal;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TPrd_PrdregrafiscalList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdregrafiscal;
    procedure SetItem(Index: Integer; Value: TPrd_Prdregrafiscal);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Prdregrafiscal;
    property Items[Index: Integer]: TPrd_Prdregrafiscal read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Prdregrafiscal }

constructor TPrd_Prdregrafiscal.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Prdregrafiscal.Destroy;
begin

  inherited;
end;

{ TPrd_PrdregrafiscalList }

constructor TPrd_PrdregrafiscalList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Prdregrafiscal);
end;

function TPrd_PrdregrafiscalList.Add: TPrd_Prdregrafiscal;
begin
  Result := TPrd_Prdregrafiscal(inherited Add);
  Result.create;
end;

function TPrd_PrdregrafiscalList.GetItem(Index: Integer): TPrd_Prdregrafiscal;
begin
  Result := TPrd_Prdregrafiscal(inherited GetItem(Index));
end;

procedure TPrd_PrdregrafiscalList.SetItem(Index: Integer; Value: TPrd_Prdregrafiscal);
begin
  inherited SetItem(Index, Value);
end;

end.