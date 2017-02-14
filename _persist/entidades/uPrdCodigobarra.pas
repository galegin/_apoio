unit uPrdCodigobarra;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Codigobarra = class;
  TPrd_CodigobarraClass = class of TPrd_Codigobarra;

  TPrd_CodigobarraList = class;
  TPrd_CodigobarraListClass = class of TPrd_CodigobarraList;

  TPrd_Codigobarra = class(TcCollectionItem)
  private
    fCd_Barraprd: String;
    fU_Version: String;
    fCd_Produto: Real;
    fQt_Embalagem: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Padrao: String;
    fTp_Barra: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Barraprd : String read fCd_Barraprd write fCd_Barraprd;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Qt_Embalagem : Real read fQt_Embalagem write fQt_Embalagem;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Tp_Barra : Real read fTp_Barra write fTp_Barra;
  end;

  TPrd_CodigobarraList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Codigobarra;
    procedure SetItem(Index: Integer; Value: TPrd_Codigobarra);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Codigobarra;
    property Items[Index: Integer]: TPrd_Codigobarra read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Codigobarra }

constructor TPrd_Codigobarra.Create;
begin

end;

destructor TPrd_Codigobarra.Destroy;
begin

  inherited;
end;

{ TPrd_CodigobarraList }

constructor TPrd_CodigobarraList.Create(AOwner: TPersistent);
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