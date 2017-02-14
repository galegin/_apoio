unit uPrdComposicaoi;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Composicaoi = class;
  TPrd_ComposicaoiClass = class of TPrd_Composicaoi;

  TPrd_ComposicaoiList = class;
  TPrd_ComposicaoiListClass = class of TPrd_ComposicaoiList;

  TPrd_Composicaoi = class(TcCollectionItem)
  private
    fCd_Composicao: Real;
    fCd_Fibra: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Composicao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Composicao : Real read fCd_Composicao write fCd_Composicao;
    property Cd_Fibra : Real read fCd_Fibra write fCd_Fibra;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Composicao : Real read fPr_Composicao write fPr_Composicao;
  end;

  TPrd_ComposicaoiList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Composicaoi;
    procedure SetItem(Index: Integer; Value: TPrd_Composicaoi);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Composicaoi;
    property Items[Index: Integer]: TPrd_Composicaoi read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Composicaoi }

constructor TPrd_Composicaoi.Create;
begin

end;

destructor TPrd_Composicaoi.Destroy;
begin

  inherited;
end;

{ TPrd_ComposicaoiList }

constructor TPrd_ComposicaoiList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Composicaoi);
end;

function TPrd_ComposicaoiList.Add: TPrd_Composicaoi;
begin
  Result := TPrd_Composicaoi(inherited Add);
  Result.create;
end;

function TPrd_ComposicaoiList.GetItem(Index: Integer): TPrd_Composicaoi;
begin
  Result := TPrd_Composicaoi(inherited GetItem(Index));
end;

procedure TPrd_ComposicaoiList.SetItem(Index: Integer; Value: TPrd_Composicaoi);
begin
  inherited SetItem(Index, Value);
end;

end.