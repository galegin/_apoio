unit uPesTipocampo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Tipocampo = class;
  TPes_TipocampoClass = class of TPes_Tipocampo;

  TPes_TipocampoList = class;
  TPes_TipocampoListClass = class of TPes_TipocampoList;

  TPes_Tipocampo = class(TcCollectionItem)
  private
    fCd_Tipocampo: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Tipocampo: String;
    fDs_Titulo: String;
    fTp_Campo: Real;
    fNr_Tamanho: Real;
    fNr_Decimal: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Tipocampo : Real read fCd_Tipocampo write fCd_Tipocampo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Tipocampo : String read fDs_Tipocampo write fDs_Tipocampo;
    property Ds_Titulo : String read fDs_Titulo write fDs_Titulo;
    property Tp_Campo : Real read fTp_Campo write fTp_Campo;
    property Nr_Tamanho : Real read fNr_Tamanho write fNr_Tamanho;
    property Nr_Decimal : Real read fNr_Decimal write fNr_Decimal;
  end;

  TPes_TipocampoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Tipocampo;
    procedure SetItem(Index: Integer; Value: TPes_Tipocampo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Tipocampo;
    property Items[Index: Integer]: TPes_Tipocampo read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Tipocampo }

constructor TPes_Tipocampo.Create;
begin

end;

destructor TPes_Tipocampo.Destroy;
begin

  inherited;
end;

{ TPes_TipocampoList }

constructor TPes_TipocampoList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Tipocampo);
end;

function TPes_TipocampoList.Add: TPes_Tipocampo;
begin
  Result := TPes_Tipocampo(inherited Add);
  Result.create;
end;

function TPes_TipocampoList.GetItem(Index: Integer): TPes_Tipocampo;
begin
  Result := TPes_Tipocampo(inherited GetItem(Index));
end;

procedure TPes_TipocampoList.SetItem(Index: Integer; Value: TPes_Tipocampo);
begin
  inherited SetItem(Index, Value);
end;

end.