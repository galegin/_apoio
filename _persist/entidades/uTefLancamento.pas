unit uTefLancamento;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Lancamento = class;
  TTef_LancamentoClass = class of TTef_Lancamento;

  TTef_LancamentoList = class;
  TTef_LancamentoListClass = class of TTef_LancamentoList;

  TTef_Lancamento = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Lancamento: Real;
    fNr_Identificacao: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Transacao: TDateTime;
    fTp_Arquivo: String;
    fNr_Nsu: Real;
    fDt_Cadastro: TDateTime;
    fNr_Docvinc: Real;
    fVl_Transacao: Real;
    fHr_Transacao: TDateTime;
    fNm_Redetef: String;
    fCd_Tefstatus: Real;
    fTp_Transacao: Real;
    fCd_Autorizacao: Real;
    fTp_Status: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Lancamento : Real read fCd_Lancamento write fCd_Lancamento;
    property Nr_Identificacao : Real read fNr_Identificacao write fNr_Identificacao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Tp_Arquivo : String read fTp_Arquivo write fTp_Arquivo;
    property Nr_Nsu : Real read fNr_Nsu write fNr_Nsu;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Docvinc : Real read fNr_Docvinc write fNr_Docvinc;
    property Vl_Transacao : Real read fVl_Transacao write fVl_Transacao;
    property Hr_Transacao : TDateTime read fHr_Transacao write fHr_Transacao;
    property Nm_Redetef : String read fNm_Redetef write fNm_Redetef;
    property Cd_Tefstatus : Real read fCd_Tefstatus write fCd_Tefstatus;
    property Tp_Transacao : Real read fTp_Transacao write fTp_Transacao;
    property Cd_Autorizacao : Real read fCd_Autorizacao write fCd_Autorizacao;
    property Tp_Status : String read fTp_Status write fTp_Status;
  end;

  TTef_LancamentoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Lancamento;
    procedure SetItem(Index: Integer; Value: TTef_Lancamento);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Lancamento;
    property Items[Index: Integer]: TTef_Lancamento read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Lancamento }

constructor TTef_Lancamento.Create;
begin

end;

destructor TTef_Lancamento.Destroy;
begin

  inherited;
end;

{ TTef_LancamentoList }

constructor TTef_LancamentoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Lancamento);
end;

function TTef_LancamentoList.Add: TTef_Lancamento;
begin
  Result := TTef_Lancamento(inherited Add);
  Result.create;
end;

function TTef_LancamentoList.GetItem(Index: Integer): TTef_Lancamento;
begin
  Result := TTef_Lancamento(inherited GetItem(Index));
end;

procedure TTef_LancamentoList.SetItem(Index: Integer; Value: TTef_Lancamento);
begin
  inherited SetItem(Index, Value);
end;

end.