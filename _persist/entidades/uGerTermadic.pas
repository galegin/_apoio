unit uGerTermadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Termadic = class;
  TGer_TermadicClass = class of TGer_Termadic;

  TGer_TermadicList = class;
  TGer_TermadicListClass = class of TGer_TermadicList;

  TGer_Termadic = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Terminal: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Path: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Terminal : Real read fCd_Terminal write fCd_Terminal;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Path : String read fDs_Path write fDs_Path;
  end;

  TGer_TermadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Termadic;
    procedure SetItem(Index: Integer; Value: TGer_Termadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Termadic;
    property Items[Index: Integer]: TGer_Termadic read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Termadic }

constructor TGer_Termadic.Create;
begin

end;

destructor TGer_Termadic.Destroy;
begin

  inherited;
end;

{ TGer_TermadicList }

constructor TGer_TermadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Termadic);
end;

function TGer_TermadicList.Add: TGer_Termadic;
begin
  Result := TGer_Termadic(inherited Add);
  Result.create;
end;

function TGer_TermadicList.GetItem(Index: Integer): TGer_Termadic;
begin
  Result := TGer_Termadic(inherited GetItem(Index));
end;

procedure TGer_TermadicList.SetItem(Index: Integer; Value: TGer_Termadic);
begin
  inherited SetItem(Index, Value);
end;

end.