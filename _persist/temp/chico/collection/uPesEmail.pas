unit uPesEmail;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Email = class;
  TPes_EmailClass = class of TPes_Email;

  TPes_EmailList = class;
  TPes_EmailListClass = class of TPes_EmailList;

  TPes_Email = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fNr_Sequencia: String;
    fU_Version: String;
    fCd_Tipoemail: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Email: String;
    fIn_Padrao: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property Nr_Sequencia : String read fNr_Sequencia write SetNr_Sequencia;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Tipoemail : String read fCd_Tipoemail write SetCd_Tipoemail;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Email : String read fDs_Email write SetDs_Email;
    property In_Padrao : String read fIn_Padrao write SetIn_Padrao;
  end;

  TPes_EmailList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Email;
    procedure SetItem(Index: Integer; Value: TPes_Email);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Email;
    property Items[Index: Integer]: TPes_Email read GetItem write SetItem; default;
  end;

implementation

{ TPes_Email }

constructor TPes_Email.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Email.Destroy;
begin

  inherited;
end;

{ TPes_EmailList }

constructor TPes_EmailList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Email);
end;

function TPes_EmailList.Add: TPes_Email;
begin
  Result := TPes_Email(inherited Add);
  Result.create;
end;

function TPes_EmailList.GetItem(Index: Integer): TPes_Email;
begin
  Result := TPes_Email(inherited GetItem(Index));
end;

procedure TPes_EmailList.SetItem(Index: Integer; Value: TPes_Email);
begin
  inherited SetItem(Index, Value);
end;

end.