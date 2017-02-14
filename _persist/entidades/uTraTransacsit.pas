unit uTraTransacsit;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacsit = class;
  TTra_TransacsitClass = class of TTra_Transacsit;

  TTra_TransacsitList = class;
  TTra_TransacsitListClass = class of TTra_TransacsitList;

  TTra_Transacsit = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fDt_Movimento: TDateTime;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Componente: String;
    fCd_Motivocanc: Real;
    fCd_Motivobloq: Real;
    fDs_Motivoalt: String;
    fTp_Situacaoant: Real;
    fTp_Situacao: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Cd_Motivocanc : Real read fCd_Motivocanc write fCd_Motivocanc;
    property Cd_Motivobloq : Real read fCd_Motivobloq write fCd_Motivobloq;
    property Ds_Motivoalt : String read fDs_Motivoalt write fDs_Motivoalt;
    property Tp_Situacaoant : Real read fTp_Situacaoant write fTp_Situacaoant;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
  end;

  TTra_TransacsitList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacsit;
    procedure SetItem(Index: Integer; Value: TTra_Transacsit);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacsit;
    property Items[Index: Integer]: TTra_Transacsit read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacsit }

constructor TTra_Transacsit.Create;
begin

end;

destructor TTra_Transacsit.Destroy;
begin

  inherited;
end;

{ TTra_TransacsitList }

constructor TTra_TransacsitList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacsit);
end;

function TTra_TransacsitList.Add: TTra_Transacsit;
begin
  Result := TTra_Transacsit(inherited Add);
  Result.create;
end;

function TTra_TransacsitList.GetItem(Index: Integer): TTra_Transacsit;
begin
  Result := TTra_Transacsit(inherited GetItem(Index));
end;

procedure TTra_TransacsitList.SetItem(Index: Integer; Value: TTra_Transacsit);
begin
  inherited SetItem(Index, Value);
end;

end.