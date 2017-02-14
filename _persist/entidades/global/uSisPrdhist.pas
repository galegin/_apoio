unit uSisPrdhist;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TSis_Prdhist = class;
  TSis_PrdhistClass = class of TSis_Prdhist;

  TSis_PrdhistList = class;
  TSis_PrdhistListClass = class of TSis_PrdhistList;

  TSis_Prdhist = class(TcCollectionItem)
  private
    fCd_Historico: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDs_Historico: String;
    fDs_Histabrev: String;
    fDt_Cadastro: TDateTime;
    fDs_Estorno: String;
    fDs_Estnabrev: String;
    fTp_Operacao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Ds_Historico : String read fDs_Historico write fDs_Historico;
    property Ds_Histabrev : String read fDs_Histabrev write fDs_Histabrev;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Estorno : String read fDs_Estorno write fDs_Estorno;
    property Ds_Estnabrev : String read fDs_Estnabrev write fDs_Estnabrev;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
  end;

  TSis_PrdhistList = class(TcCollection)
  private
    function GetItem(Index: Integer): TSis_Prdhist;
    procedure SetItem(Index: Integer; Value: TSis_Prdhist);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TSis_Prdhist;
    property Items[Index: Integer]: TSis_Prdhist read GetItem write SetItem; default;
  end;
  
implementation

{ TSis_Prdhist }

constructor TSis_Prdhist.Create;
begin

end;

destructor TSis_Prdhist.Destroy;
begin

  inherited;
end;

{ TSis_PrdhistList }

constructor TSis_PrdhistList.Create(AOwner: TPersistent);
begin
  inherited Create(TSis_Prdhist);
end;

function TSis_PrdhistList.Add: TSis_Prdhist;
begin
  Result := TSis_Prdhist(inherited Add);
  Result.create;
end;

function TSis_PrdhistList.GetItem(Index: Integer): TSis_Prdhist;
begin
  Result := TSis_Prdhist(inherited GetItem(Index));
end;

procedure TSis_PrdhistList.SetItem(Index: Integer; Value: TSis_Prdhist);
begin
  inherited SetItem(Index, Value);
end;

end.