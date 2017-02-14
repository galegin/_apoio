unit uPesEmail;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Email = class;
  TPes_EmailClass = class of TPes_Email;

  TPes_EmailList = class;
  TPes_EmailListClass = class of TPes_EmailList;

  TPes_Email = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Tipoemail: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Email: String;
    fIn_Padrao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipoemail : Real read fCd_Tipoemail write fCd_Tipoemail;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Email : String read fDs_Email write fDs_Email;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
  end;

  TPes_EmailList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Email;
    procedure SetItem(Index: Integer; Value: TPes_Email);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Email;
    property Items[Index: Integer]: TPes_Email read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Email }

constructor TPes_Email.Create;
begin

end;

destructor TPes_Email.Destroy;
begin

  inherited;
end;

{ TPes_EmailList }

constructor TPes_EmailList.Create(AOwner: TPersistent);
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