unit uPesCliportador;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Cliportador = class;
  TPes_CliportadorClass = class of TPes_Cliportador;

  TPes_CliportadorList = class;
  TPes_CliportadorListClass = class of TPes_CliportadorList;

  TPes_Cliportador = class(TcCollectionItem)
  private
    fCd_Cliente: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNr_Portador: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nr_Portador : Real read fNr_Portador write fNr_Portador;
  end;

  TPes_CliportadorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Cliportador;
    procedure SetItem(Index: Integer; Value: TPes_Cliportador);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Cliportador;
    property Items[Index: Integer]: TPes_Cliportador read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Cliportador }

constructor TPes_Cliportador.Create;
begin

end;

destructor TPes_Cliportador.Destroy;
begin

  inherited;
end;

{ TPes_CliportadorList }

constructor TPes_CliportadorList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Cliportador);
end;

function TPes_CliportadorList.Add: TPes_Cliportador;
begin
  Result := TPes_Cliportador(inherited Add);
  Result.create;
end;

function TPes_CliportadorList.GetItem(Index: Integer): TPes_Cliportador;
begin
  Result := TPes_Cliportador(inherited GetItem(Index));
end;

procedure TPes_CliportadorList.SetItem(Index: Integer; Value: TPes_Cliportador);
begin
  inherited SetItem(Index, Value);
end;

end.