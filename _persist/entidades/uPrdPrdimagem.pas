unit uPrdPrdimagem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdimagem = class;
  TPrd_PrdimagemClass = class of TPrd_Prdimagem;

  TPrd_PrdimagemList = class;
  TPrd_PrdimagemListClass = class of TPrd_PrdimagemList;

  TPrd_Prdimagem = class(TcCollectionItem)
  private
    fCd_Produto: Real;
    fCd_Imagem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Padrao: String;
    fTp_Imagem: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Imagem : Real read fCd_Imagem write fCd_Imagem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Tp_Imagem : Real read fTp_Imagem write fTp_Imagem;
  end;

  TPrd_PrdimagemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdimagem;
    procedure SetItem(Index: Integer; Value: TPrd_Prdimagem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdimagem;
    property Items[Index: Integer]: TPrd_Prdimagem read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdimagem }

constructor TPrd_Prdimagem.Create;
begin

end;

destructor TPrd_Prdimagem.Destroy;
begin

  inherited;
end;

{ TPrd_PrdimagemList }

constructor TPrd_PrdimagemList.Create(AOwner: TPersistent);
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