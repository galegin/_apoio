unit uPesCliadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Cliadic = class;
  TPes_CliadicClass = class of TPes_Cliadic;

  TPes_CliadicList = class;
  TPes_CliadicListClass = class of TPes_CliadicList;

  TPes_Cliadic = class(TcCollectionItem)
  private
    fCd_Cliente: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Vectolimite: TDateTime;
    fIn_Restrito: String;
    fCd_Conceito: String;
    fCd_Tabdesc: Real;
    fNr_Diabasevencto: Real;
    fNr_Diascarencia: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Vectolimite : TDateTime read fDt_Vectolimite write fDt_Vectolimite;
    property In_Restrito : String read fIn_Restrito write fIn_Restrito;
    property Cd_Conceito : String read fCd_Conceito write fCd_Conceito;
    property Cd_Tabdesc : Real read fCd_Tabdesc write fCd_Tabdesc;
    property Nr_Diabasevencto : Real read fNr_Diabasevencto write fNr_Diabasevencto;
    property Nr_Diascarencia : Real read fNr_Diascarencia write fNr_Diascarencia;
  end;

  TPes_CliadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Cliadic;
    procedure SetItem(Index: Integer; Value: TPes_Cliadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Cliadic;
    property Items[Index: Integer]: TPes_Cliadic read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Cliadic }

constructor TPes_Cliadic.Create;
begin

end;

destructor TPes_Cliadic.Destroy;
begin

  inherited;
end;

{ TPes_CliadicList }

constructor TPes_CliadicList.Create(AOwner: TPersistent);
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