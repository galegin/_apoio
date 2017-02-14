unit uVGerBanco;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TV_Ger_Banco = class;
  TV_Ger_BancoClass = class of TV_Ger_Banco;

  TV_Ger_BancoList = class;
  TV_Ger_BancoListClass = class of TV_Ger_BancoList;

  TV_Ger_Banco = class(TcCollectionItem)
  private
    fNr_Banco: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fNm_Banco: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Banco : Real read fNr_Banco write fNr_Banco;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Nm_Banco : String read fNm_Banco write fNm_Banco;
  end;

  TV_Ger_BancoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TV_Ger_Banco;
    procedure SetItem(Index: Integer; Value: TV_Ger_Banco);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TV_Ger_Banco;
    property Items[Index: Integer]: TV_Ger_Banco read GetItem write SetItem; default;
  end;
  
implementation

{ TV_Ger_Banco }

constructor TV_Ger_Banco.Create;
begin

end;

destructor TV_Ger_Banco.Destroy;
begin

  inherited;
end;

{ TV_Ger_BancoList }

constructor TV_Ger_BancoList.Create(AOwner: TPersistent);
begin
  inherited Create(TV_Ger_Banco);
end;

function TV_Ger_BancoList.Add: TV_Ger_Banco;
begin
  Result := TV_Ger_Banco(inherited Add);
  Result.create;
end;

function TV_Ger_BancoList.GetItem(Index: Integer): TV_Ger_Banco;
begin
  Result := TV_Ger_Banco(inherited GetItem(Index));
end;

procedure TV_Ger_BancoList.SetItem(Index: Integer; Value: TV_Ger_Banco);
begin
  inherited SetItem(Index, Value);
end;

end.