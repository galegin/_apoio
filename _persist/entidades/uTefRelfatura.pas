unit uTefRelfatura;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTef_Relfatura = class;
  TTef_RelfaturaClass = class of TTef_Relfatura;

  TTef_RelfaturaList = class;
  TTef_RelfaturaListClass = class of TTef_RelfaturaList;

  TTef_Relfatura = class(TcCollectionItem)
  private
    fCd_Emptef: Real;
    fDt_Movimento: TDateTime;
    fNr_Seq: Real;
    fCd_Empfatura: Real;
    fCd_Cliente: Real;
    fNr_Fatura: Real;
    fNr_Parcela: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Emptef : Real read fCd_Emptef write fCd_Emptef;
    property Dt_Movimento : TDateTime read fDt_Movimento write fDt_Movimento;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property Cd_Empfatura : Real read fCd_Empfatura write fCd_Empfatura;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TTef_RelfaturaList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTef_Relfatura;
    procedure SetItem(Index: Integer; Value: TTef_Relfatura);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTef_Relfatura;
    property Items[Index: Integer]: TTef_Relfatura read GetItem write SetItem; default;
  end;
  
implementation

{ TTef_Relfatura }

constructor TTef_Relfatura.Create;
begin

end;

destructor TTef_Relfatura.Destroy;
begin

  inherited;
end;

{ TTef_RelfaturaList }

constructor TTef_RelfaturaList.Create(AOwner: TPersistent);
begin
  inherited Create(TTef_Relfatura);
end;

function TTef_RelfaturaList.Add: TTef_Relfatura;
begin
  Result := TTef_Relfatura(inherited Add);
  Result.create;
end;

function TTef_RelfaturaList.GetItem(Index: Integer): TTef_Relfatura;
begin
  Result := TTef_Relfatura(inherited GetItem(Index));
end;

procedure TTef_RelfaturaList.SetItem(Index: Integer; Value: TTef_Relfatura);
begin
  inherited SetItem(Index, Value);
end;

end.