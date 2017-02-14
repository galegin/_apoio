unit uPrdPrdinfoadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Prdinfoadic = class;
  TPrd_PrdinfoadicClass = class of TPrd_Prdinfoadic;

  TPrd_PrdinfoadicList = class;
  TPrd_PrdinfoadicListClass = class of TPrd_PrdinfoadicList;

  TPrd_Prdinfoadic = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Produto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fQt_Compmultipla: Real;
    fQt_Compeconomica: Real;
    fNr_Variacao: Real;
    fTp_Freqvenda: Real;
    fCd_Agruplotec: Real;
    fCd_Agruplotei: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Qt_Compmultipla : Real read fQt_Compmultipla write fQt_Compmultipla;
    property Qt_Compeconomica : Real read fQt_Compeconomica write fQt_Compeconomica;
    property Nr_Variacao : Real read fNr_Variacao write fNr_Variacao;
    property Tp_Freqvenda : Real read fTp_Freqvenda write fTp_Freqvenda;
    property Cd_Agruplotec : Real read fCd_Agruplotec write fCd_Agruplotec;
    property Cd_Agruplotei : Real read fCd_Agruplotei write fCd_Agruplotei;
  end;

  TPrd_PrdinfoadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Prdinfoadic;
    procedure SetItem(Index: Integer; Value: TPrd_Prdinfoadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Prdinfoadic;
    property Items[Index: Integer]: TPrd_Prdinfoadic read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Prdinfoadic }

constructor TPrd_Prdinfoadic.Create;
begin

end;

destructor TPrd_Prdinfoadic.Destroy;
begin

  inherited;
end;

{ TPrd_PrdinfoadicList }

constructor TPrd_PrdinfoadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Prdinfoadic);
end;

function TPrd_PrdinfoadicList.Add: TPrd_Prdinfoadic;
begin
  Result := TPrd_Prdinfoadic(inherited Add);
  Result.create;
end;

function TPrd_PrdinfoadicList.GetItem(Index: Integer): TPrd_Prdinfoadic;
begin
  Result := TPrd_Prdinfoadic(inherited GetItem(Index));
end;

procedure TPrd_PrdinfoadicList.SetItem(Index: Integer; Value: TPrd_Prdinfoadic);
begin
  inherited SetItem(Index, Value);
end;

end.