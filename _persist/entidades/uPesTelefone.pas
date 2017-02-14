unit uPesTelefone;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Telefone = class;
  TPes_TelefoneClass = class of TPes_Telefone;

  TPes_TelefoneList = class;
  TPes_TelefoneListClass = class of TPes_TelefoneList;

  TPes_Telefone = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Tipofone: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Telefone: String;
    fIn_Padrao: String;
    fNr_Ramal: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Tipofone : Real read fCd_Tipofone write fCd_Tipofone;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Telefone : String read fNr_Telefone write fNr_Telefone;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
    property Nr_Ramal : Real read fNr_Ramal write fNr_Ramal;
  end;

  TPes_TelefoneList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Telefone;
    procedure SetItem(Index: Integer; Value: TPes_Telefone);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Telefone;
    property Items[Index: Integer]: TPes_Telefone read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Telefone }

constructor TPes_Telefone.Create;
begin

end;

destructor TPes_Telefone.Destroy;
begin

  inherited;
end;

{ TPes_TelefoneList }

constructor TPes_TelefoneList.Create(AOwner: TPersistent);
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