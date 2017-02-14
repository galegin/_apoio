unit uFccMov;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcc_Mov = class;
  TFcc_MovClass = class of TFcc_Mov;

  TFcc_MovList = class;
  TFcc_MovListClass = class of TFcc_MovList;

  TFcc_Mov = class(TcCollectionItem)
  private
    fNr_Ctapes: Real;
    fDt_Movim: TDateTime;
    fNr_Seqmov: Real;
    fU_Version: String;
    fCd_Historico: Real;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fTp_Operacao: String;
    fCd_Empresa: Real;
    fCd_Grupoempresa: Real;
    fVl_Lancto: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fCd_Operconci: Real;
    fCd_Operestorno: Real;
    fDs_Aux: String;
    fDs_Doc: String;
    fDt_Conci: TDateTime;
    fDt_Estorno: TDateTime;
    fIn_Estorno: String;
    fIn_Fechado: String;
    fCd_Tipoclas: Real;
    fCd_Clas: String;
    fCd_Empchqpres: Real;
    fCd_Clichqpres: Real;
    fNr_Chequepres: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Nr_Ctapes : Real read fNr_Ctapes write fNr_Ctapes;
    property Dt_Movim : TDateTime read fDt_Movim write fDt_Movim;
    property Nr_Seqmov : Real read fNr_Seqmov write fNr_Seqmov;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Historico : Real read fCd_Historico write fCd_Historico;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property Tp_Operacao : String read fTp_Operacao write fTp_Operacao;
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Vl_Lancto : Real read fVl_Lancto write fVl_Lancto;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Cd_Operconci : Real read fCd_Operconci write fCd_Operconci;
    property Cd_Operestorno : Real read fCd_Operestorno write fCd_Operestorno;
    property Ds_Aux : String read fDs_Aux write fDs_Aux;
    property Ds_Doc : String read fDs_Doc write fDs_Doc;
    property Dt_Conci : TDateTime read fDt_Conci write fDt_Conci;
    property Dt_Estorno : TDateTime read fDt_Estorno write fDt_Estorno;
    property In_Estorno : String read fIn_Estorno write fIn_Estorno;
    property In_Fechado : String read fIn_Fechado write fIn_Fechado;
    property Cd_Tipoclas : Real read fCd_Tipoclas write fCd_Tipoclas;
    property Cd_Clas : String read fCd_Clas write fCd_Clas;
    property Cd_Empchqpres : Real read fCd_Empchqpres write fCd_Empchqpres;
    property Cd_Clichqpres : Real read fCd_Clichqpres write fCd_Clichqpres;
    property Nr_Chequepres : Real read fNr_Chequepres write fNr_Chequepres;
  end;

  TFcc_MovList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcc_Mov;
    procedure SetItem(Index: Integer; Value: TFcc_Mov);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcc_Mov;
    property Items[Index: Integer]: TFcc_Mov read GetItem write SetItem; default;
  end;
  
implementation

{ TFcc_Mov }

constructor TFcc_Mov.Create;
begin

end;

destructor TFcc_Mov.Destroy;
begin

  inherited;
end;

{ TFcc_MovList }

constructor TFcc_MovList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcc_Mov);
end;

function TFcc_MovList.Add: TFcc_Mov;
begin
  Result := TFcc_Mov(inherited Add);
  Result.create;
end;

function TFcc_MovList.GetItem(Index: Integer): TFcc_Mov;
begin
  Result := TFcc_Mov(inherited GetItem(Index));
end;

procedure TFcc_MovList.SetItem(Index: Integer; Value: TFcc_Mov);
begin
  inherited SetItem(Index, Value);
end;

end.