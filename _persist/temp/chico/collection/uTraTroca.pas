unit uTraTroca;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TTra_Troca = class;
  TTra_TrocaClass = class of TTra_Troca;

  TTra_TrocaList = class;
  TTra_TrocaListClass = class of TTra_TrocaList;

  TTra_Troca = class(TmCollectionItem)
  private
    fCd_Empdev: String;
    fNr_Tradev: String;
    fDt_Tradev: String;
    fCd_Empven: String;
    fNr_Traven: String;
    fDt_Traven: String;
    fU_Version: String;
    fCd_Empfatdev: String;
    fCd_Grupoempdev: String;
    fCd_Empfatven: String;
    fCd_Grupoempven: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Difitem: String;
    fQt_Difpecas: String;
    fVl_Diferenca: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empdev : String read fCd_Empdev write SetCd_Empdev;
    property Nr_Tradev : String read fNr_Tradev write SetNr_Tradev;
    property Dt_Tradev : String read fDt_Tradev write SetDt_Tradev;
    property Cd_Empven : String read fCd_Empven write SetCd_Empven;
    property Nr_Traven : String read fNr_Traven write SetNr_Traven;
    property Dt_Traven : String read fDt_Traven write SetDt_Traven;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfatdev : String read fCd_Empfatdev write SetCd_Empfatdev;
    property Cd_Grupoempdev : String read fCd_Grupoempdev write SetCd_Grupoempdev;
    property Cd_Empfatven : String read fCd_Empfatven write SetCd_Empfatven;
    property Cd_Grupoempven : String read fCd_Grupoempven write SetCd_Grupoempven;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nr_Difitem : String read fNr_Difitem write SetNr_Difitem;
    property Qt_Difpecas : String read fQt_Difpecas write SetQt_Difpecas;
    property Vl_Diferenca : String read fVl_Diferenca write SetVl_Diferenca;
  end;

  TTra_TrocaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TTra_Troca;
    procedure SetItem(Index: Integer; Value: TTra_Troca);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TTra_Troca;
    property Items[Index: Integer]: TTra_Troca read GetItem write SetItem; default;
  end;

implementation

{ TTra_Troca }

constructor TTra_Troca.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TTra_Troca.Destroy;
begin

  inherited;
end;

{ TTra_TrocaList }

constructor TTra_TrocaList.Create(AOwner: TPersistentCollection);
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