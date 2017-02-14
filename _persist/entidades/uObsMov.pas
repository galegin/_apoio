unit uObsMov;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TObs_Mov = class;
  TObs_MovClass = class of TObs_Mov;

  TObs_MovList = class;
  TObs_MovListClass = class of TObs_MovList;

  TObs_Mov = class(TcCollectionItem)
  private
    fNr_Ctapes: Real;
    fDt_Movim: TDateTime;
    fNr_Seqmov: Real;
    fNr_Linha: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Componente: String;
    fIn_Manutencao: String;
    fDs_Obs: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : TDateTime read fDt_Movim write fDt_Movim;
    property Nr_Seqmov : Real read fNr_Seqmov write fNr_Seqmov;
    property Nr_Linha : Real read fNr_Linha write fNr_Linha;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property In_Manutencao : String read fIn_Manutencao write fIn_Manutencao;
    property Ds_Obs : String read fDs_Obs write fDs_Obs;
  end;

  TObs_MovList = class(TcCollection)
  private
    function GetItem(Index: Integer): TObs_Mov;
    procedure SetItem(Index: Integer; Value: TObs_Mov);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TObs_Mov;
    property Items[Index: Integer]: TObs_Mov read GetItem write SetItem; default;
  end;
  
implementation

{ TObs_Mov }

constructor TObs_Mov.Create;
begin

end;

destructor TObs_Mov.Destroy;
begin

  inherited;
end;

{ TObs_MovList }

constructor TObs_MovList.Create(AOwner: TPersistent);
begin
  inherited Create(TObs_Mov);
end;

function TObs_MovList.Add: TObs_Mov;
begin
  Result := TObs_Mov(inherited Add);
  Result.create;
end;

function TObs_MovList.GetItem(Index: Integer): TObs_Mov;
begin
  Result := TObs_Mov(inherited GetItem(Index));
end;

procedure TObs_MovList.SetItem(Index: Integer; Value: TObs_Mov);
begin
  inherited SetItem(Index, Value);
end;

end.