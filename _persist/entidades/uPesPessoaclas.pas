unit uPesPessoaclas;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pessoaclas = class;
  TPes_PessoaclasClass = class of TPes_Pessoaclas;

  TPes_PessoaclasList = class;
  TPes_PessoaclasListClass = class of TPes_PessoaclasList;

  TPes_Pessoaclas = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fCd_Tipoclas: Real;
    fCd_Classificacao: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Classificacao : String read fCd_Classificacao write fCd_Classificacao;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPes_PessoaclasList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pessoaclas;
    procedure SetItem(Index: Integer; Value: TPes_Pessoaclas);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pessoaclas;
    property Items[Index: Integer]: TPes_Pessoaclas read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pessoaclas }

constructor TPes_Pessoaclas.Create;
begin

end;

destructor TPes_Pessoaclas.Destroy;
begin

  inherited;
end;

{ TPes_PessoaclasList }

constructor TPes_PessoaclasList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Pessoaclas);
end;

function TPes_PessoaclasList.Add: TPes_Pessoaclas;
begin
  Result := TPes_Pessoaclas(inherited Add);
  Result.create;
end;

function TPes_PessoaclasList.GetItem(Index: Integer): TPes_Pessoaclas;
begin
  Result := TPes_Pessoaclas(inherited GetItem(Index));
end;

procedure TPes_PessoaclasList.SetItem(Index: Integer; Value: TPes_Pessoaclas);
begin
  inherited SetItem(Index, Value);
end;

end.