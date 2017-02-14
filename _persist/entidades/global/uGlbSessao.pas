unit uGlbSessao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGlb_Sessao = class;
  TGlb_SessaoClass = class of TGlb_Sessao;

  TGlb_SessaoList = class;
  TGlb_SessaoListClass = class of TGlb_SessaoList;

  TGlb_Sessao = class(TcCollectionItem)
  private
    fCd_Usuarioso: String;
    fDs_Serial: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Sessoes: Real;
    fNr_Sessoesusu: Real;
    fNr_Bonus: Real;
    fDt_Bonus: TDateTime;
    fNr_Sessoesrepr: Real;
    fNr_Sessoespdv: Real;
    fNr_Sessoescons: Real;
    fNr_Sessoesmob: Real;
    fQt_01: String;
    fQt_02: String;
    fQt_03: String;
    fQt_04: String;
    fQt_05: String;
    fQt_06: String;
    fQt_07: String;
    fQt_08: String;
    fDt_01: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Usuarioso : String read fCd_Usuarioso write fCd_Usuarioso;
    property Ds_Serial : String read fDs_Serial write fDs_Serial;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Sessoes : Real read fNr_Sessoes write fNr_Sessoes;
    property Nr_Sessoesusu : Real read fNr_Sessoesusu write fNr_Sessoesusu;
    property Nr_Bonus : Real read fNr_Bonus write fNr_Bonus;
    property Dt_Bonus : TDateTime read fDt_Bonus write fDt_Bonus;
    property Nr_Sessoesrepr : Real read fNr_Sessoesrepr write fNr_Sessoesrepr;
    property Nr_Sessoespdv : Real read fNr_Sessoespdv write fNr_Sessoespdv;
    property Nr_Sessoescons : Real read fNr_Sessoescons write fNr_Sessoescons;
    property Nr_Sessoesmob : Real read fNr_Sessoesmob write fNr_Sessoesmob;
    property Qt_01 : String read fQt_01 write fQt_01;
    property Qt_02 : String read fQt_02 write fQt_02;
    property Qt_03 : String read fQt_03 write fQt_03;
    property Qt_04 : String read fQt_04 write fQt_04;
    property Qt_05 : String read fQt_05 write fQt_05;
    property Qt_06 : String read fQt_06 write fQt_06;
    property Qt_07 : String read fQt_07 write fQt_07;
    property Qt_08 : String read fQt_08 write fQt_08;
    property Dt_01 : String read fDt_01 write fDt_01;
  end;

  TGlb_SessaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGlb_Sessao;
    procedure SetItem(Index: Integer; Value: TGlb_Sessao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGlb_Sessao;
    property Items[Index: Integer]: TGlb_Sessao read GetItem write SetItem; default;
  end;
  
implementation

{ TGlb_Sessao }

constructor TGlb_Sessao.Create;
begin

end;

destructor TGlb_Sessao.Destroy;
begin

  inherited;
end;

{ TGlb_SessaoList }

constructor TGlb_SessaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGlb_Sessao);
end;

function TGlb_SessaoList.Add: TGlb_Sessao;
begin
  Result := TGlb_Sessao(inherited Add);
  Result.create;
end;

function TGlb_SessaoList.GetItem(Index: Integer): TGlb_Sessao;
begin
  Result := TGlb_Sessao(inherited GetItem(Index));
end;

procedure TGlb_SessaoList.SetItem(Index: Integer; Value: TGlb_Sessao);
begin
  inherited SetItem(Index, Value);
end;

end.