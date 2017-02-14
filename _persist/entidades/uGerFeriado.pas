unit uGerFeriado;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Feriado = class;
  TGer_FeriadoClass = class of TGer_Feriado;

  TGer_FeriadoList = class;
  TGer_FeriadoListClass = class of TGer_FeriadoList;

  TGer_Feriado = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Turno: Real;
    fDt_Feriado: TDateTime;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Feriado: Real;
    fDs_Feriado: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Turno : Real read fCd_Turno write fCd_Turno;
    property Dt_Feriado : TDateTime read fDt_Feriado write fDt_Feriado;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Feriado : Real read fTp_Feriado write fTp_Feriado;
    property Ds_Feriado : String read fDs_Feriado write fDs_Feriado;
  end;

  TGer_FeriadoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Feriado;
    procedure SetItem(Index: Integer; Value: TGer_Feriado);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Feriado;
    property Items[Index: Integer]: TGer_Feriado read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Feriado }

constructor TGer_Feriado.Create;
begin

end;

destructor TGer_Feriado.Destroy;
begin

  inherited;
end;

{ TGer_FeriadoList }

constructor TGer_FeriadoList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Feriado);
end;

function TGer_FeriadoList.Add: TGer_Feriado;
begin
  Result := TGer_Feriado(inherited Add);
  Result.create;
end;

function TGer_FeriadoList.GetItem(Index: Integer): TGer_Feriado;
begin
  Result := TGer_Feriado(inherited GetItem(Index));
end;

procedure TGer_FeriadoList.SetItem(Index: Integer; Value: TGer_Feriado);
begin
  inherited SetItem(Index, Value);
end;

end.