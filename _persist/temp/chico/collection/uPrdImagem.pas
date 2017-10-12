unit uPrdImagem;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Imagem = class;
  TPrd_ImagemClass = class of TPrd_Imagem;

  TPrd_ImagemList = class;
  TPrd_ImagemListClass = class of TPrd_ImagemList;

  TPrd_Imagem = class(TmCollectionItem)
  private
    fCd_Imagem: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNm_Imagem: String;
    fDs_Imagem: String;
    fDs_Arquivo: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Imagem : String read fCd_Imagem write SetCd_Imagem;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nm_Imagem : String read fNm_Imagem write SetNm_Imagem;
    property Ds_Imagem : String read fDs_Imagem write SetDs_Imagem;
    property Ds_Arquivo : String read fDs_Arquivo write SetDs_Arquivo;
  end;

  TPrd_ImagemList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Imagem;
    procedure SetItem(Index: Integer; Value: TPrd_Imagem);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Imagem;
    property Items[Index: Integer]: TPrd_Imagem read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Imagem }

constructor TPrd_Imagem.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Imagem.Destroy;
begin

  inherited;
end;

{ TPrd_ImagemList }

constructor TPrd_ImagemList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Imagem);
end;

function TPrd_ImagemList.Add: TPrd_Imagem;
begin
  Result := TPrd_Imagem(inherited Add);
  Result.create;
end;

function TPrd_ImagemList.GetItem(Index: Integer): TPrd_Imagem;
begin
  Result := TPrd_Imagem(inherited GetItem(Index));
end;

procedure TPrd_ImagemList.SetItem(Index: Integer; Value: TPrd_Imagem);
begin
  inherited SetItem(Index, Value);
end;

end.