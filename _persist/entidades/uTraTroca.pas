unit uTraTroca;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Troca = class;
  TTra_TrocaClass = class of TTra_Troca;

  TTra_TrocaList = class;
  TTra_TrocaListClass = class of TTra_TrocaList;

  TTra_Troca = class(TcCollectionItem)
  private
    fCd_Empdev: Real;
    fNr_Tradev: Real;
    fDt_Tradev: TDateTime;
    fCd_Empven: Real;
    fNr_Traven: Real;
    fDt_Traven: TDateTime;
    fU_Version: String;
    fCd_Empfatdev: Real;
    fCd_Grupoempdev: Real;
    fCd_Empfatven: Real;
    fCd_Grupoempven: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Difitem: Real;
    fQt_Difpecas: Real;
    fVl_Diferenca: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empdev : Real read fCd_Empdev write fCd_Empdev;
    property Nr_Tradev : Real read fNr_Tradev write fNr_Tradev;
    property Dt_Tradev : TDateTime read fDt_Tradev write fDt_Tradev;
    property Cd_Empven : Real read fCd_Empven write fCd_Empven;
    property Nr_Traven : Real read fNr_Traven write fNr_Traven;
    property Dt_Traven : TDateTime read fDt_Traven write fDt_Traven;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfatdev : Real read fCd_Empfatdev write fCd_Empfatdev;
    property Cd_Grupoempdev : Real read fCd_Grupoempdev write fCd_Grupoempdev;
    property Cd_Empfatven : Real read fCd_Empfatven write fCd_Empfatven;
    property Cd_Grupoempven : Real read fCd_Grupoempven write fCd_Grupoempven;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Difitem : Real read fNr_Difitem write fNr_Difitem;
    property Qt_Difpecas : Real read fQt_Difpecas write fQt_Difpecas;
    property Vl_Diferenca : Real read fVl_Diferenca write fVl_Diferenca;
  end;

  TTra_TrocaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Troca;
    procedure SetItem(Index: Integer; Value: TTra_Troca);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Troca;
    property Items[Index: Integer]: TTra_Troca read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Troca }

constructor TTra_Troca.Create;
begin

end;

destructor TTra_Troca.Destroy;
begin

  inherited;
end;

{ TTra_TrocaList }

constructor TTra_TrocaList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Troca);
end;

function TTra_TrocaList.Add: TTra_Troca;
begin
  Result := TTra_Troca(inherited Add);
  Result.create;
end;

function TTra_TrocaList.GetItem(Index: Integer): TTra_Troca;
begin
  Result := TTra_Troca(inherited GetItem(Index));
end;

procedure TTra_TrocaList.SetItem(Index: Integer; Value: TTra_Troca);
begin
  inherited SetItem(Index, Value);
end;

end.