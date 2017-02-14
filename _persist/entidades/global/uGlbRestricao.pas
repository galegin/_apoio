unit uGlbRestricao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Restricao = class;
  TGlb_RestricaoClass = class of TGlb_Restricao;

  TGlb_RestricaoList = class;
  TGlb_RestricaoListClass = class of TGlb_RestricaoList;

  TGlb_Restricao = class(TcCollectionItem)
  private
    fCd_Componente: String;
    fDs_Campo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Restricao: Real;
    fDs_Restricao: String;
    fIn_Empresa: String;
    fDs_Observacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Restricao : Real read fTp_Restricao write fTp_Restricao;
    property Ds_Restricao : String read fDs_Restricao write fDs_Restricao;
    property In_Empresa : String read fIn_Empresa write fIn_Empresa;
    property Ds_Observacao : String read fDs_Observacao write fDs_Observacao;
  end;

  TGlb_RestricaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Restricao;
    procedure SetItem(Index: Integer; Value: TGlb_Restricao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Restricao;
    property Items[Index: Integer]: TGlb_Restricao read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Restricao }

constructor TGlb_Restricao.Create;
begin

end;

destructor TGlb_Restricao.Destroy;
begin

  inherited;
end;

{ TGlb_RestricaoList }

constructor TGlb_RestricaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Restricao);
end;

function TGlb_RestricaoList.Add: TGlb_Restricao;
begin
  Result := TGlb_Restricao(inherited Add);
  Result.create;
end;

function TGlb_RestricaoList.GetItem(Index: Integer): TGlb_Restricao;
begin
  Result := TGlb_Restricao(inherited GetItem(Index));
end;

procedure TGlb_RestricaoList.SetItem(Index: Integer; Value: TGlb_Restricao);
begin
  inherited SetItem(Index, Value);
end;

end.