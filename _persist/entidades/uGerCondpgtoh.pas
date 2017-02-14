unit uGerCondpgtoh;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Condpgtoh = class;
  TGer_CondpgtohClass = class of TGer_Condpgtoh;

  TGer_CondpgtohList = class;
  TGer_CondpgtohListClass = class of TGer_CondpgtohList;

  TGer_Condpgtoh = class(TcCollectionItem)
  private
    fCd_Condpgto: Real;
    fTp_Documento: Real;
    fNr_Seqhistrelsub: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Variacao: Real;
    fDs_Resumida: String;
    fIn_Descvariacao: String;
    fPr_Entrada: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Condpgto : Real read fCd_Condpgto write fCd_Condpgto;
    property Tp_Documento : Real read fTp_Documento write fTp_Documento;
    property Nr_Seqhistrelsub : Real read fNr_Seqhistrelsub write fNr_Seqhistrelsub;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Variacao : Real read fPr_Variacao write fPr_Variacao;
    property Ds_Resumida : String read fDs_Resumida write fDs_Resumida;
    property In_Descvariacao : String read fIn_Descvariacao write fIn_Descvariacao;
    property Pr_Entrada : Real read fPr_Entrada write fPr_Entrada;
  end;

  TGer_CondpgtohList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Condpgtoh;
    procedure SetItem(Index: Integer; Value: TGer_Condpgtoh);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Condpgtoh;
    property Items[Index: Integer]: TGer_Condpgtoh read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Condpgtoh }

constructor TGer_Condpgtoh.Create;
begin

end;

destructor TGer_Condpgtoh.Destroy;
begin

  inherited;
end;

{ TGer_CondpgtohList }

constructor TGer_CondpgtohList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Condpgtoh);
end;

function TGer_CondpgtohList.Add: TGer_Condpgtoh;
begin
  Result := TGer_Condpgtoh(inherited Add);
  Result.create;
end;

function TGer_CondpgtohList.GetItem(Index: Integer): TGer_Condpgtoh;
begin
  Result := TGer_Condpgtoh(inherited GetItem(Index));
end;

procedure TGer_CondpgtohList.SetItem(Index: Integer; Value: TGer_Condpgtoh);
begin
  inherited SetItem(Index, Value);
end;

end.