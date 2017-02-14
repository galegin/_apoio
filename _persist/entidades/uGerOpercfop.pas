unit uGerOpercfop;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Opercfop = class;
  TGer_OpercfopClass = class of TGer_Opercfop;

  TGer_OpercfopList = class;
  TGer_OpercfopListClass = class of TGer_OpercfopList;

  TGer_Opercfop = class(TcCollectionItem)
  private
    fCd_Operacao: Real;
    fCd_Cfop: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fIn_Kardex: String;
    fIn_Financeiro: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Operacao : Real read fCd_Operacao write fCd_Operacao;
    property Cd_Cfop : Real read fCd_Cfop write fCd_Cfop;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property In_Kardex : String read fIn_Kardex write fIn_Kardex;
    property In_Financeiro : String read fIn_Financeiro write fIn_Financeiro;
  end;

  TGer_OpercfopList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Opercfop;
    procedure SetItem(Index: Integer; Value: TGer_Opercfop);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Opercfop;
    property Items[Index: Integer]: TGer_Opercfop read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Opercfop }

constructor TGer_Opercfop.Create;
begin

end;

destructor TGer_Opercfop.Destroy;
begin

  inherited;
end;

{ TGer_OpercfopList }

constructor TGer_OpercfopList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Opercfop);
end;

function TGer_OpercfopList.Add: TGer_Opercfop;
begin
  Result := TGer_Opercfop(inherited Add);
  Result.create;
end;

function TGer_OpercfopList.GetItem(Index: Integer): TGer_Opercfop;
begin
  Result := TGer_Opercfop(inherited GetItem(Index));
end;

procedure TGer_OpercfopList.SetItem(Index: Integer; Value: TGer_Opercfop);
begin
  inherited SetItem(Index, Value);
end;

end.