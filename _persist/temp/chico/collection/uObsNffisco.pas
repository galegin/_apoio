unit uObsNffisco;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TObs_Nffisco = class;
  TObs_NffiscoClass = class of TObs_Nffisco;

  TObs_NffiscoList = class;
  TObs_NffiscoListClass = class of TObs_NffiscoList;

  TObs_Nffisco = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNr_Fatura: String;
    fDt_Fatura: String;
    fNr_Linha: String;
    fU_Version: String;
    fCd_Empfat: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Observacao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nr_Fatura : String read fNr_Fatura write SetNr_Fatura;
    property Dt_Fatura : String read fDt_Fatura write SetDt_Fatura;
    property Nr_Linha : String read fNr_Linha write SetNr_Linha;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Empfat : String read fCd_Empfat write SetCd_Empfat;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Observacao : String read fDs_Observacao write SetDs_Observacao;
  end;

  TObs_NffiscoList = class(TmCollection)
  private
    function GetItem(Index: Integer): TObs_Nffisco;
    procedure SetItem(Index: Integer; Value: TObs_Nffisco);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TObs_Nffisco;
    property Items[Index: Integer]: TObs_Nffisco read GetItem write SetItem; default;
  end;

implementation

{ TObs_Nffisco }

constructor TObs_Nffisco.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TObs_Nffisco.Destroy;
begin

  inherited;
end;

{ TObs_NffiscoList }

constructor TObs_NffiscoList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TObs_Nffisco);
end;

function TObs_NffiscoList.Add: TObs_Nffisco;
begin
  Result := TObs_Nffisco(inherited Add);
  Result.create;
end;

function TObs_NffiscoList.GetItem(Index: Integer): TObs_Nffisco;
begin
  Result := TObs_Nffisco(inherited GetItem(Index));
end;

procedure TObs_NffiscoList.SetItem(Index: Integer; Value: TObs_Nffisco);
begin
  inherited SetItem(Index, Value);
end;

end.