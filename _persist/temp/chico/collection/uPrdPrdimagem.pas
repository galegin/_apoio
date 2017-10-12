unit uPrdPrdimagem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Prdimagem = class;
  TPrd_PrdimagemClass = class of TPrd_Prdimagem;

  TPrd_PrdimagemList = class;
  TPrd_PrdimagemListClass = class of TPrd_PrdimagemList;

  TPrd_Prdimagem = class(TmCollectionItem)
  private
    fCd_Produto: String;
    fCd_Imagem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Padrao: String;
    fTp_Imagem: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Cd_Imagem : String read fCd_Imagem write SetCd_Imagem;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write SetIn_Padrao;
    property Tp_Imagem : String read fTp_Imagem write SetTp_Imagem;
  end;

  TPrd_PrdimagemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdimagem;
    procedure SetItem(Index: Integer; Value: TPrd_Prdimagem);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Prdimagem;
    property Items[Index: Integer]: TPrd_Prdimagem read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Prdimagem }

constructor TPrd_Prdimagem.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Prdimagem.Destroy;
begin

  inherited;
end;

{ TPrd_PrdimagemList }

constructor TPrd_PrdimagemList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Prdimagem);
end;

function TPrd_PrdimagemList.Add: TPrd_Prdimagem;
begin
  Result := TPrd_Prdimagem(inherited Add);
  Result.create;
end;

function TPrd_PrdimagemList.GetItem(Index: Integer): TPrd_Prdimagem;
begin
  Result := TPrd_Prdimagem(inherited GetItem(Index));
end;

procedure TPrd_PrdimagemList.SetItem(Index: Integer; Value: TPrd_Prdimagem);
begin
  inherited SetItem(Index, Value);
end;

end.