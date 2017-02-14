unit uTraTransacnf;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transacnf = class;
  TTra_TransacnfClass = class of TTra_Transacnf;

  TTra_TransacnfList = class;
  TTra_TransacnfListClass = class of TTra_TransacnfList;

  TTra_Transacnf = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Empresanf: Real;
    fCd_Pessoanf: Real;
    fNr_Nf: Real;
    fCd_Serie: String;
    fDt_Emissao: TDateTime;
    fTp_Origememissao: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Operacao: String;
    fVl_Ratdesconto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Empresanf : Real read fCd_Empresanf write fCd_Empresanf;
    property Cd_Pessoanf : Real read fCd_Pessoanf write fCd_Pessoanf;
    property Nr_Nf : Real read fNr_Nf write fNr_Nf;
    property Cd_Serie : String read fCd_Serie write fCd_Serie;
    property Dt_Emissao : TDateTime read fDt_Emissao write fDt_Emissao;
    property Tp_Origememissao : String read fTp_Origememissao write fTp_Origememissao;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Vl_Ratdesconto : Real read fVl_Ratdesconto write fVl_Ratdesconto;
  end;

  TTra_TransacnfList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transacnf;
    procedure SetItem(Index: Integer; Value: TTra_Transacnf);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transacnf;
    property Items[Index: Integer]: TTra_Transacnf read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transacnf }

constructor TTra_Transacnf.Create;
begin

end;

destructor TTra_Transacnf.Destroy;
begin

  inherited;
end;

{ TTra_TransacnfList }

constructor TTra_TransacnfList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transacnf);
end;

function TTra_TransacnfList.Add: TTra_Transacnf;
begin
  Result := TTra_Transacnf(inherited Add);
  Result.create;
end;

function TTra_TransacnfList.GetItem(Index: Integer): TTra_Transacnf;
begin
  Result := TTra_Transacnf(inherited GetItem(Index));
end;

procedure TTra_TransacnfList.SetItem(Index: Integer; Value: TTra_Transacnf);
begin
  inherited SetItem(Index, Value);
end;

end.