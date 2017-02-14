unit uTraTranscondpgtoh;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TTra_Transcondpgtoh = class;
  TTra_TranscondpgtohClass = class of TTra_Transcondpgtoh;

  TTra_TranscondpgtohList = class;
  TTra_TranscondpgtohListClass = class of TTra_TranscondpgtohList;

  TTra_Transcondpgtoh = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Transacao: Real;
    fDt_Transacao: TDateTime;
    fCd_Condpgto: Real;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fVl_Entrada: Real;
    fVl_Credev: Real;
    fVl_Adiantamento: Real;
    fVl_Desconto: Real;
    fPr_Desconto: Real;
    fDt_Base: TDateTime;
    fVl_Acrescimo: Real;
    fPr_Acrescimo: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Transacao : Real read fNr_Transacao write fNr_Transacao;
    property Dt_Transacao : TDateTime read fDt_Transacao write fDt_Transacao;
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Vl_Entrada : Real read fVl_Entrada write fVl_Entrada;
    property Vl_Credev : Real read fVl_Credev write fVl_Credev;
    property Vl_Adiantamento : Real read fVl_Adiantamento write fVl_Adiantamento;
    property Vl_Desconto : Real read fVl_Desconto write fVl_Desconto;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Dt_Base : TDateTime read fDt_Base write fDt_Base;
    property Vl_Acrescimo : Real read fVl_Acrescimo write fVl_Acrescimo;
    property Pr_Acrescimo : Real read fPr_Acrescimo write fPr_Acrescimo;
  end;

  TTra_TranscondpgtohList = class(TcCollection)
  private
    function GetItem(Index: Integer): TTra_Transcondpgtoh;
    procedure SetItem(Index: Integer; Value: TTra_Transcondpgtoh);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TTra_Transcondpgtoh;
    property Items[Index: Integer]: TTra_Transcondpgtoh read GetItem write SetItem; default;
  end;
  
implementation

{ TTra_Transcondpgtoh }

constructor TTra_Transcondpgtoh.Create;
begin

end;

destructor TTra_Transcondpgtoh.Destroy;
begin

  inherited;
end;

{ TTra_TranscondpgtohList }

constructor TTra_TranscondpgtohList.Create(AOwner: TPersistent);
begin
  inherited Create(TTra_Transcondpgtoh);
end;

function TTra_TranscondpgtohList.Add: TTra_Transcondpgtoh;
begin
  Result := TTra_Transcondpgtoh(inherited Add);
  Result.create;
end;

function TTra_TranscondpgtohList.GetItem(Index: Integer): TTra_Transcondpgtoh;
begin
  Result := TTra_Transcondpgtoh(inherited GetItem(Index));
end;

procedure TTra_TranscondpgtohList.SetItem(Index: Integer; Value: TTra_Transcondpgtoh);
begin
  inherited SetItem(Index, Value);
end;

end.