unit uPrdCodigobarra;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPrd_Codigobarra = class;
  TPrd_CodigobarraClass = class of TPrd_Codigobarra;

  TPrd_CodigobarraList = class;
  TPrd_CodigobarraListClass = class of TPrd_CodigobarraList;

  TPrd_Codigobarra = class(TmCollectionItem)
  private
    fCd_Barraprd: String;
    fU_Version: String;
    fCd_Produto: String;
    fQt_Embalagem: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Padrao: String;
    fTp_Barra: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Barraprd : String read fCd_Barraprd write SetCd_Barraprd;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Produto : String read fCd_Produto write SetCd_Produto;
    property Qt_Embalagem : String read fQt_Embalagem write SetQt_Embalagem;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write SetIn_Padrao;
    property Tp_Barra : String read fTp_Barra write SetTp_Barra;
  end;

  TPrd_CodigobarraList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPrd_Codigobarra;
    procedure SetItem(Index: Integer; Value: TPrd_Codigobarra);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPrd_Codigobarra;
    property Items[Index: Integer]: TPrd_Codigobarra read GetItem write SetItem; default;
  end;

implementation

{ TPrd_Codigobarra }

constructor TPrd_Codigobarra.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPrd_Codigobarra.Destroy;
begin

  inherited;
end;

{ TPrd_CodigobarraList }

constructor TPrd_CodigobarraList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPrd_Codigobarra);
end;

function TPrd_CodigobarraList.Add: TPrd_Codigobarra;
begin
  Result := TPrd_Codigobarra(inherited Add);
  Result.create;
end;

function TPrd_CodigobarraList.GetItem(Index: Integer): TPrd_Codigobarra;
begin
  Result := TPrd_Codigobarra(inherited GetItem(Index));
end;

procedure TPrd_CodigobarraList.SetItem(Index: Integer; Value: TPrd_Codigobarra);
begin
  inherited SetItem(Index, Value);
end;

end.