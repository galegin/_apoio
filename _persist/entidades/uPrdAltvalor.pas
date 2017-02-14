unit uPrdAltvalor;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPrd_Altvalor = class;
  TPrd_AltvalorClass = class of TPrd_Altvalor;

  TPrd_AltvalorList = class;
  TPrd_AltvalorListClass = class of TPrd_AltvalorList;

  TPrd_Altvalor = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Produto: Real;
    fTp_Valor: String;
    fCd_Valor: Real;
    fDt_Movimento: TDateTime;
    fNr_Sequencia: Real;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Motivo: Real;
    fVl_Anterior: Real;
    fVl_Atualizado: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : Real read fCd_Valor write fCd_Valor;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Nr_Sequencia : Real read fNr_Sequencia write fNr_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Motivo : Real read fCd_Motivo write fCd_Motivo;
    property Vl_Anterior : Real read fVl_Anterior write fVl_Anterior;
    property Vl_Atualizado : Real read fVl_Atualizado write fVl_Atualizado;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TPrd_AltvalorList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPrd_Altvalor;
    procedure SetItem(Index: Integer; Value: TPrd_Altvalor);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPrd_Altvalor;
    property Items[Index: Integer]: TPrd_Altvalor read GetItem write SetItem; default;
  end;
  
implementation

{ TPrd_Altvalor }

constructor TPrd_Altvalor.Create;
begin

end;

destructor TPrd_Altvalor.Destroy;
begin

  inherited;
end;

{ TPrd_AltvalorList }

constructor TPrd_AltvalorList.Create(AOwner: TPersistent);
begin
  inherited Create(TPrd_Altvalor);
end;

function TPrd_AltvalorList.Add: TPrd_Altvalor;
begin
  Result := TPrd_Altvalor(inherited Add);
  Result.create;
end;

function TPrd_AltvalorList.GetItem(Index: Integer): TPrd_Altvalor;
begin
  Result := TPrd_Altvalor(inherited GetItem(Index));
end;

procedure TPrd_AltvalorList.SetItem(Index: Integer; Value: TPrd_Altvalor);
begin
  inherited SetItem(Index, Value);
end;

end.