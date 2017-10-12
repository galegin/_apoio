unit uPesCliadic;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Cliadic = class;
  TPes_CliadicClass = class of TPes_Cliadic;

  TPes_CliadicList = class;
  TPes_CliadicListClass = class of TPes_CliadicList;

  TPes_Cliadic = class(TmCollectionItem)
  private
    fCd_Cliente: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDt_Vectolimite: String;
    fIn_Restrito: String;
    fCd_Conceito: String;
    fCd_Tabdesc: String;
    fNr_Diabasevencto: String;
    fNr_Diascarencia: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Cliente : String read fCd_Cliente write SetCd_Cliente;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Dt_Vectolimite : String read fDt_Vectolimite write SetDt_Vectolimite;
    property In_Restrito : String read fIn_Restrito write SetIn_Restrito;
    property Cd_Conceito : String read fCd_Conceito write SetCd_Conceito;
    property Cd_Tabdesc : String read fCd_Tabdesc write SetCd_Tabdesc;
    property Nr_Diabasevencto : String read fNr_Diabasevencto write SetNr_Diabasevencto;
    property Nr_Diascarencia : String read fNr_Diascarencia write SetNr_Diascarencia;
  end;

  TPes_CliadicList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Cliadic;
    procedure SetItem(Index: Integer; Value: TPes_Cliadic);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Cliadic;
    property Items[Index: Integer]: TPes_Cliadic read GetItem write SetItem; default;
  end;

implementation

{ TPes_Cliadic }

constructor TPes_Cliadic.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Cliadic.Destroy;
begin

  inherited;
end;

{ TPes_CliadicList }

constructor TPes_CliadicList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Cliadic);
end;

function TPes_CliadicList.Add: TPes_Cliadic;
begin
  Result := TPes_Cliadic(inherited Add);
  Result.create;
end;

function TPes_CliadicList.GetItem(Index: Integer): TPes_Cliadic;
begin
  Result := TPes_Cliadic(inherited GetItem(Index));
end;

procedure TPes_CliadicList.SetItem(Index: Integer; Value: TPes_Cliadic);
begin
  inherited SetItem(Index, Value);
end;

end.