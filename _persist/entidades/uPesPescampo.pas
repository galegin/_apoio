unit uPesPescampo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pescampo = class;
  TPes_PescampoClass = class of TPes_Pescampo;

  TPes_PescampoList = class;
  TPes_PescampoListClass = class of TPes_PescampoList;

  TPes_Pescampo = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fCd_Tipocampo: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Campo: String;
    fNr_Campo: Real;
    fDt_Campo: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Tipocampo : Real read fCd_Tipocampo write fCd_Tipocampo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Campo : String read fDs_Campo write fDs_Campo;
    property Nr_Campo : Real read fNr_Campo write fNr_Campo;
    property Dt_Campo : TDateTime read fDt_Campo write fDt_Campo;
  end;

  TPes_PescampoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pescampo;
    procedure SetItem(Index: Integer; Value: TPes_Pescampo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pescampo;
    property Items[Index: Integer]: TPes_Pescampo read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pescampo }

constructor TPes_Pescampo.Create;
begin

end;

destructor TPes_Pescampo.Destroy;
begin

  inherited;
end;

{ TPes_PescampoList }

constructor TPes_PescampoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Pescampo);
end;

function TPes_PescampoList.Add: TPes_Pescampo;
begin
  Result := TPes_Pescampo(inherited Add);
  Result.create;
end;

function TPes_PescampoList.GetItem(Index: Integer): TPes_Pescampo;
begin
  Result := TPes_Pescampo(inherited GetItem(Index));
end;

procedure TPes_PescampoList.SetItem(Index: Integer; Value: TPes_Pescampo);
begin
  inherited SetItem(Index, Value);
end;

end.