unit uPesTelefone;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Telefone = class;
  TPes_TelefoneClass = class of TPes_Telefone;

  TPes_TelefoneList = class;
  TPes_TelefoneListClass = class of TPes_TelefoneList;

  TPes_Telefone = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipofone: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fNr_Telefone: String;
    fIn_Padrao: String;
    fNr_Ramal: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Tipofone : String read fCd_Tipofone write SetCd_Tipofone;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Nr_Telefone : String read fNr_Telefone write SetNr_Telefone;
    property In_Padrao : String read fIn_Padrao write SetIn_Padrao;
    property Nr_Ramal : String read fNr_Ramal write SetNr_Ramal;
  end;

  TPes_TelefoneList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Telefone;
    procedure SetItem(Index: Integer; Value: TPes_Telefone);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Telefone;
    property Items[Index: Integer]: TPes_Telefone read GetItem write SetItem; default;
  end;

implementation

{ TPes_Telefone }

constructor TPes_Telefone.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Telefone.Destroy;
begin

  inherited;
end;

{ TPes_TelefoneList }

constructor TPes_TelefoneList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Telefone);
end;

function TPes_TelefoneList.Add: TPes_Telefone;
begin
  Result := TPes_Telefone(inherited Add);
  Result.create;
end;

function TPes_TelefoneList.GetItem(Index: Integer): TPes_Telefone;
begin
  Result := TPes_Telefone(inherited GetItem(Index));
end;

procedure TPes_TelefoneList.SetItem(Index: Integer; Value: TPes_Telefone);
begin
  inherited SetItem(Index, Value);
end;

end.