unit uGerNrdtseq;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Nrdtseq = class;
  TGer_NrdtseqClass = class of TGer_Nrdtseq;

  TGer_NrdtseqList = class;
  TGer_NrdtseqListClass = class of TGer_NrdtseqList;

  TGer_Nrdtseq = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNm_Entidade: String;
    fNm_Atributo: String;
    fDt_Sequencia: TDateTime;
    fU_Version: String;
    fNr_Incremento: Real;
    fNr_Atual: Real;
    fNr_Inicial: Real;
    fNr_Final: Real;
    fIn_Reiniciar: String;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nm_Entidade : String read fNm_Entidade write fNm_Entidade;
    property Nm_Atributo : String read fNm_Atributo write fNm_Atributo;
    property Dt_Sequencia : TDateTime read fDt_Sequencia write fDt_Sequencia;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Incremento : Real read fNr_Incremento write fNr_Incremento;
    property Nr_Atual : Real read fNr_Atual write fNr_Atual;
    property Nr_Inicial : Real read fNr_Inicial write fNr_Inicial;
    property Nr_Final : Real read fNr_Final write fNr_Final;
    property In_Reiniciar : String read fIn_Reiniciar write fIn_Reiniciar;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_NrdtseqList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Nrdtseq;
    procedure SetItem(Index: Integer; Value: TGer_Nrdtseq);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Nrdtseq;
    property Items[Index: Integer]: TGer_Nrdtseq read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Nrdtseq }

constructor TGer_Nrdtseq.Create;
begin

end;

destructor TGer_Nrdtseq.Destroy;
begin

  inherited;
end;

{ TGer_NrdtseqList }

constructor TGer_NrdtseqList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Nrdtseq);
end;

function TGer_NrdtseqList.Add: TGer_Nrdtseq;
begin
  Result := TGer_Nrdtseq(inherited Add);
  Result.create;
end;

function TGer_NrdtseqList.GetItem(Index: Integer): TGer_Nrdtseq;
begin
  Result := TGer_Nrdtseq(inherited GetItem(Index));
end;

procedure TGer_NrdtseqList.SetItem(Index: Integer; Value: TGer_Nrdtseq);
begin
  inherited SetItem(Index, Value);
end;

end.