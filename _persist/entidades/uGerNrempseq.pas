unit uGerNrempseq;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Nrempseq = class;
  TGer_NrempseqClass = class of TGer_Nrempseq;

  TGer_NrempseqList = class;
  TGer_NrempseqListClass = class of TGer_NrempseqList;

  TGer_Nrempseq = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNm_Entidade: String;
    fNm_Atributo: String;
    fU_Version: String;
    fNr_Incremento: Real;
    fNr_Atual: Real;
    fNr_Inicial: Real;
    fNr_Final: Real;
    fIn_Reiniciar: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nm_Entidade : String read fNm_Entidade write fNm_Entidade;
    property Nm_Atributo : String read fNm_Atributo write fNm_Atributo;
    property U_Version : String read fU_Version write fU_Version;
    property Nr_Incremento : Real read fNr_Incremento write fNr_Incremento;
    property Nr_Atual : Real read fNr_Atual write fNr_Atual;
    property Nr_Inicial : Real read fNr_Inicial write fNr_Inicial;
    property Nr_Final : Real read fNr_Final write fNr_Final;
    property In_Reiniciar : String read fIn_Reiniciar write fIn_Reiniciar;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
  end;

  TGer_NrempseqList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Nrempseq;
    procedure SetItem(Index: Integer; Value: TGer_Nrempseq);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Nrempseq;
    property Items[Index: Integer]: TGer_Nrempseq read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Nrempseq }

constructor TGer_Nrempseq.Create;
begin

end;

destructor TGer_Nrempseq.Destroy;
begin

  inherited;
end;

{ TGer_NrempseqList }

constructor TGer_NrempseqList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Nrempseq);
end;

function TGer_NrempseqList.Add: TGer_Nrempseq;
begin
  Result := TGer_Nrempseq(inherited Add);
  Result.create;
end;

function TGer_NrempseqList.GetItem(Index: Integer): TGer_Nrempseq;
begin
  Result := TGer_Nrempseq(inherited GetItem(Index));
end;

procedure TGer_NrempseqList.SetItem(Index: Integer; Value: TGer_Nrempseq);
begin
  inherited SetItem(Index, Value);
end;

end.