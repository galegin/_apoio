unit uGerNumseq;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Numseq = class;
  TGer_NumseqClass = class of TGer_Numseq;

  TGer_NumseqList = class;
  TGer_NumseqListClass = class of TGer_NumseqList;

  TGer_Numseq = class(TcCollectionItem)
  private
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

  TGer_NumseqList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Numseq;
    procedure SetItem(Index: Integer; Value: TGer_Numseq);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Numseq;
    property Items[Index: Integer]: TGer_Numseq read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Numseq }

constructor TGer_Numseq.Create;
begin

end;

destructor TGer_Numseq.Destroy;
begin

  inherited;
end;

{ TGer_NumseqList }

constructor TGer_NumseqList.Create(AOwner: TPersistent);
begin
  inherited Create(TGer_Numseq);
end;

function TGer_NumseqList.Add: TGer_Numseq;
begin
  Result := TGer_Numseq(inherited Add);
  Result.create;
end;

function TGer_NumseqList.GetItem(Index: Integer): TGer_Numseq;
begin
  Result := TGer_Numseq(inherited GetItem(Index));
end;

procedure TGer_NumseqList.SetItem(Index: Integer; Value: TGer_Numseq);
begin
  inherited SetItem(Index, Value);
end;

end.