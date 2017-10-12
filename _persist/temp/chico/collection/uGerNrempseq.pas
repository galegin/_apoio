unit uGerNrempseq;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Nrempseq = class;
  TGer_NrempseqClass = class of TGer_Nrempseq;

  TGer_NrempseqList = class;
  TGer_NrempseqListClass = class of TGer_NrempseqList;

  TGer_Nrempseq = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fNm_Entidade: String;
    fNm_Atributo: String;
    fU_Version: String;
    fNr_Incremento: String;
    fNr_Atual: String;
    fNr_Inicial: String;
    fNr_Final: String;
    fIn_Reiniciar: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Nm_Entidade : String read fNm_Entidade write SetNm_Entidade;
    property Nm_Atributo : String read fNm_Atributo write SetNm_Atributo;
    property U_Version : String read fU_Version write SetU_Version;
    property Nr_Incremento : String read fNr_Incremento write SetNr_Incremento;
    property Nr_Atual : String read fNr_Atual write SetNr_Atual;
    property Nr_Inicial : String read fNr_Inicial write SetNr_Inicial;
    property Nr_Final : String read fNr_Final write SetNr_Final;
    property In_Reiniciar : String read fIn_Reiniciar write SetIn_Reiniciar;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
  end;

  TGer_NrempseqList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Nrempseq;
    procedure SetItem(Index: Integer; Value: TGer_Nrempseq);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Nrempseq;
    property Items[Index: Integer]: TGer_Nrempseq read GetItem write SetItem; default;
  end;

implementation

{ TGer_Nrempseq }

constructor TGer_Nrempseq.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Nrempseq.Destroy;
begin

  inherited;
end;

{ TGer_NrempseqList }

constructor TGer_NrempseqList.Create(AOwner: TPersistentCollection);
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