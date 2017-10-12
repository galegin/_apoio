unit uTraVencimento;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Vencimento = class;
  TTra_VencimentoClass = class of TTra_Vencimento;

  TTra_VencimentoList = class;
  TTra_VencimentoListClass = class of TTra_VencimentoList;

  TTra_Vencimento = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Transacao: String;
    fDt_Transacao: String;
    fNr_Parcela: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Vencimento: String;
    fDt_Baixa: String;
    fNr_Dctoorigem: String;
    fVl_Parcela: String;
    fTp_Formapgto: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Transacao : String read fNr_Transacao write SetNr_Transacao;
    property Dt_Transacao : String read fDt_Transacao write SetDt_Transacao;
    property Nr_Parcela : String read fNr_Parcela write SetNr_Parcela;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Vencimento : String read fDt_Vencimento write SetDt_Vencimento;
    property Dt_Baixa : String read fDt_Baixa write SetDt_Baixa;
    property Nr_Dctoorigem : String read fNr_Dctoorigem write SetNr_Dctoorigem;
    property Vl_Parcela : String read fVl_Parcela write SetVl_Parcela;
    property Tp_Formapgto : String read fTp_Formapgto write SetTp_Formapgto;
  end;

  TTra_VencimentoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Vencimento;
    procedure SetItem(Index: Integer; Value: TTra_Vencimento);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Vencimento;
    property Items[Index: Integer]: TTra_Vencimento read GetItem write SetItem; default;
  end;

implementation

{ TTra_Vencimento }

constructor TTra_Vencimento.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Vencimento.Destroy;
begin

  inherited;
end;

{ TTra_VencimentoList }

constructor TTra_VencimentoList.Create(AOwner: TPersistentCollection);
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