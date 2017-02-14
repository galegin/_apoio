unit uPrdImagem;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Imagem = class;
  TPrd_ImagemClass = class of TPrd_Imagem;

  TPrd_ImagemList = class;
  TPrd_ImagemListClass = class of TPrd_ImagemList;

  TPrd_Imagem = class(TcCollectionItem)
  private
    fCd_Imagem: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Imagem: String;
    fDs_Imagem: String;
    fDs_Arquivo: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Imagem : Real read fCd_Imagem write fCd_Imagem;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Imagem : String read fNm_Imagem write fNm_Imagem;
    property Ds_Imagem : String read fDs_Imagem write fDs_Imagem;
    property Ds_Arquivo : String read fDs_Arquivo write fDs_Arquivo;
  end;

  TPrd_ImagemList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Imagem;
    procedure SetItem(Index: Integer; Value: TPrd_Imagem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Imagem;
    property Items[Index: Integer]: TPrd_Imagem read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Imagem }

constructor TPrd_Imagem.Create;
begin

end;

destructor TPrd_Imagem.Destroy;
begin

  inherited;
end;

{ TPrd_ImagemList }

constructor TPrd_ImagemList.Create(AOwner: TPersistent);
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