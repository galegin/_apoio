unit uCtcTracartao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TCtc_Tracartao = class;
  TCtc_TracartaoClass = class of TCtc_Tracartao;

  TCtc_TracartaoList = class;
  TCtc_TracartaoListClass = class of TCtc_TracartaoList;

  TCtc_Tracartao = class(TcCollectionItem)
  private
    fCd_Emptransacao: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Cartao: Real;
    fNr_Seqcartao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Bonusutil: Real;
    fCd_Convenio: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Emptransacao : Real read fCd_Emptransacao write fCd_Emptransacao;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Cartao : Real read fCd_Cartao write fCd_Cartao;
    property Nr_Seqcartao : Real read fNr_Seqcartao write fNr_Seqcartao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Bonusutil : Real read fVl_Bonusutil write fVl_Bonusutil;
    property Cd_Convenio : Real read fCd_Convenio write fCd_Convenio;
  end;

  TCtc_TracartaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TCtc_Tracartao;
    procedure SetItem(Index: Integer; Value: TCtc_Tracartao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TCtc_Tracartao;
    property Items[Index: Integer]: TCtc_Tracartao read GetItem write SetItem; default;
  end;
  
implementation

{ TCtc_Tracartao }

constructor TCtc_Tracartao.Create;
begin

end;

destructor TCtc_Tracartao.Destroy;
begin

  inherited;
end;

{ TCtc_TracartaoList }

constructor TCtc_TracartaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TCtc_Tracartao);
end;

function TCtc_TracartaoList.Add: TCtc_Tracartao;
begin
  Result := TCtc_Tracartao(inherited Add);
  Result.create;
end;

function TCtc_TracartaoList.GetItem(Index: Integer): TCtc_Tracartao;
begin
  Result := TCtc_Tracartao(inherited GetItem(Index));
end;

procedure TCtc_TracartaoList.SetItem(Index: Integer; Value: TCtc_Tracartao);
begin
  inherited SetItem(Index, Value);
end;

end.