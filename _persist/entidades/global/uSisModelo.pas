unit uSisModelo;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TSis_Modelo = class;
  TSis_ModeloClass = class of TSis_Modelo;

  TSis_ModeloList = class;
  TSis_ModeloListClass = class of TSis_ModeloList;

  TSis_Modelo = class(TcCollectionItem)
  private
    fCd_Modelo: String;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Modelo: String;
    fCd_Modelopai: String;
    fNr_Nivel: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Modelo : String read fCd_Modelo write fCd_Modelo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Modelo : String read fDs_Modelo write fDs_Modelo;
    property Cd_Modelopai : String read fCd_Modelopai write fCd_Modelopai;
    property Nr_Nivel : Real read fNr_Nivel write fNr_Nivel;
  end;

  TSis_ModeloList = class(TcCollection)
  private
    function GetItem(Index: Integer): TSis_Modelo;
    procedure SetItem(Index: Integer; Value: TSis_Modelo);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TSis_Modelo;
    property Items[Index: Integer]: TSis_Modelo read GetItem write SetItem; default;
  end;
  
implementation

{ TSis_Modelo }

constructor TSis_Modelo.Create;
begin

end;

destructor TSis_Modelo.Destroy;
begin

  inherited;
end;

{ TSis_ModeloList }

constructor TSis_ModeloList.Create(AOwner: TPersistent);
begin
  inherited Create(TSis_Modelo);
end;

function TSis_ModeloList.Add: TSis_Modelo;
begin
  Result := TSis_Modelo(inherited Add);
  Result.create;
end;

function TSis_ModeloList.GetItem(Index: Integer): TSis_Modelo;
begin
  Result := TSis_Modelo(inherited GetItem(Index));
end;

procedure TSis_ModeloList.SetItem(Index: Integer; Value: TSis_Modelo);
begin
  inherited SetItem(Index, Value);
end;

end.