unit uPrdPrdregrafiscal;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdregrafiscal = class;
  TPrd_PrdregrafiscalClass = class of TPrd_Prdregrafiscal;

  TPrd_PrdregrafiscalList = class;
  TPrd_PrdregrafiscalListClass = class of TPrd_PrdregrafiscalList;

  TPrd_Prdregrafiscal = class(TcCollectionItem)
  private
    fCd_Produto: Real;
    fCd_Operacao: Real;
    fU_Version: String;
    fCd_Regrafiscal: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Regrafiscal : Real read fCd_Regrafiscal write fCd_Regrafiscal;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_PrdregrafiscalList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdregrafiscal;
    procedure SetItem(Index: Integer; Value: TPrd_Prdregrafiscal);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdregrafiscal;
    property Items[Index: Integer]: TPrd_Prdregrafiscal read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdregrafiscal }

constructor TPrd_Prdregrafiscal.Create;
begin

end;

destructor TPrd_Prdregrafiscal.Destroy;
begin

  inherited;
end;

{ TPrd_PrdregrafiscalList }

constructor TPrd_PrdregrafiscalList.Create(AOwner: TPersistent);
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