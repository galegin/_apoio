unit uTraTraimposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Traimposto = class;
  TTra_TraimpostoClass = class of TTra_Traimposto;

  TTra_TraimpostoList = class;
  TTra_TraimpostoListClass = class of TTra_TraimpostoList;

  TTra_Traimposto = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Imposto: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Aliquota: Real;
    fPr_Basecalc: Real;
    fPr_Redubase: Real;
    fVl_Basecalc: Real;
    fVl_Isento: Real;
    fVl_Outro: Real;
    fVl_Imposto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Pr_Basecalc : Real read fPr_Basecalc write fPr_Basecalc;
    property Pr_Redubase : Real read fPr_Redubase write fPr_Redubase;
    property Vl_Basecalc : Real read fVl_Basecalc write fVl_Basecalc;
    property Vl_Isento : Real read fVl_Isento write fVl_Isento;
    property Vl_Outro : Real read fVl_Outro write fVl_Outro;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
  end;

  TTra_TraimpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Traimposto;
    procedure SetItem(Index: Integer; Value: TTra_Traimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Traimposto;
    property Items[Index: Integer]: TTra_Traimposto read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Traimposto }

constructor TTra_Traimposto.Create;
begin

end;

destructor TTra_Traimposto.Destroy;
begin

  inherited;
end;

{ TTra_TraimpostoList }

constructor TTra_TraimpostoList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Traimposto);
end;

function TTra_TraimpostoList.Add: TTra_Traimposto;
begin
  Result := TTra_Traimposto(inherited Add);
  Result.create;
end;

function TTra_TraimpostoList.GetItem(Index: Integer): TTra_Traimposto;
begin
  Result := TTra_Traimposto(inherited GetItem(Index));
end;

procedure TTra_TraimpostoList.SetItem(Index: Integer; Value: TTra_Traimposto);
begin
  inherited SetItem(Index, Value);
end;

end.