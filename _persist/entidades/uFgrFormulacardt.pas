unit uFgrFormulacardt;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFgr_Formulacardt = class;
  TFgr_FormulacardtClass = class of TFgr_Formulacardt;

  TFgr_FormulacardtList = class;
  TFgr_FormulacardtListClass = class of TFgr_FormulacardtList;

  TFgr_Formulacardt = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Formulacartao: Real;
    fNr_Seq: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDt_Ini: TDateTime;
    fDt_Fim: TDateTime;
    fTp_Situacao: String;
    fPr_Taxa: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Formulacartao : Real read fCd_Formulacartao write fCd_Formulacartao;
    property Nr_Seq : Real read fNr_Seq write fNr_Seq;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Dt_Ini : TDateTime read fDt_Ini write fDt_Ini;
    property Dt_Fim : TDateTime read fDt_Fim write fDt_Fim;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
    property Pr_Taxa : Real read fPr_Taxa write fPr_Taxa;
  end;

  TFgr_FormulacardtList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFgr_Formulacardt;
    procedure SetItem(Index: Integer; Value: TFgr_Formulacardt);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFgr_Formulacardt;
    property Items[Index: Integer]: TFgr_Formulacardt read GetItem write SetItem; default;
  end;
  
implementation

{ TFgr_Formulacardt }

constructor TFgr_Formulacardt.Create;
begin

end;

destructor TFgr_Formulacardt.Destroy;
begin

  inherited;
end;

{ TFgr_FormulacardtList }

constructor TFgr_FormulacardtList.Create(AOwner: TPersistent);
begin
  inherited Create(TFgr_Formulacardt);
end;

function TFgr_FormulacardtList.Add: TFgr_Formulacardt;
begin
  Result := TFgr_Formulacardt(inherited Add);
  Result.create;
end;

function TFgr_FormulacardtList.GetItem(Index: Integer): TFgr_Formulacardt;
begin
  Result := TFgr_Formulacardt(inherited GetItem(Index));
end;

procedure TFgr_FormulacardtList.SetItem(Index: Integer; Value: TFgr_Formulacardt);
begin
  inherited SetItem(Index, Value);
end;

end.