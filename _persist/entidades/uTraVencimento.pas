unit uTraVencimento;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Vencimento = class;
  TTra_VencimentoClass = class of TTra_Vencimento;

  TTra_VencimentoList = class;
  TTra_VencimentoListClass = class of TTra_VencimentoList;

  TTra_Vencimento = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Vencimento: TDateTime;
    fDt_Baixa: TDateTime;
    fNr_Dctoorigem: Real;
    fVl_Parcela: Real;
    fTp_Formapgto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Vencimento : TDateTime read fDt_Vencimento write fDt_Vencimento;
    property Dt_Baixa : TDateTime read fDt_Baixa write fDt_Baixa;
    property Nr_Dctoorigem : Real read fNr_Dctoorigem write fNr_Dctoorigem;
    property Vl_Parcela : Real read fVl_Parcela write fVl_Parcela;
    property Tp_Formapgto : Real read fTp_Formapgto write fTp_Formapgto;
  end;

  TTra_VencimentoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Vencimento;
    procedure SetItem(Index: Integer; Value: TTra_Vencimento);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Vencimento;
    property Items[Index: Integer]: TTra_Vencimento read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Vencimento }

constructor TTra_Vencimento.Create;
begin

end;

destructor TTra_Vencimento.Destroy;
begin

  inherited;
end;

{ TTra_VencimentoList }

constructor TTra_VencimentoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Vencimento);
end;

function TTra_VencimentoList.Add: TTra_Vencimento;
begin
  Result := TTra_Vencimento(inherited Add);
  Result.create;
end;

function TTra_VencimentoList.GetItem(Index: Integer): TTra_Vencimento;
begin
  Result := TTra_Vencimento(inherited GetItem(Index));
end;

procedure TTra_VencimentoList.SetItem(Index: Integer; Value: TTra_Vencimento);
begin
  inherited SetItem(Index, Value);
end;

end.