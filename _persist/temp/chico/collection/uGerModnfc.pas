unit uGerModnfc;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TGer_Modnfc = class;
  TGer_ModnfcClass = class of TGer_Modnfc;

  TGer_ModnfcList = class;
  TGer_ModnfcListClass = class of TGer_ModnfcList;

  TGer_Modnfc = class(TmCollectionItem)
  private
    fCd_Modelonf: String;
    fU_Version: String;
    fCd_Serie: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fDs_Modelonf: String;
    fNr_Colunas: String;
    fNr_Linhas: String;
    fNr_Itens: String;
    fNr_Vlunitdec: String;
    fNr_Qtunitdec: String;
    fNm_Job: String;
    fIn_Quebranf: String;
    fIn_Agrupa_Grupo: String;
    fTp_Codproduto: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Modelonf : String read fCd_Modelonf write SetCd_Modelonf;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Serie : String read fCd_Serie write SetCd_Serie;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Ds_Modelonf : String read fDs_Modelonf write SetDs_Modelonf;
    property Nr_Colunas : String read fNr_Colunas write SetNr_Colunas;
    property Nr_Linhas : String read fNr_Linhas write SetNr_Linhas;
    property Nr_Itens : String read fNr_Itens write SetNr_Itens;
    property Nr_Vlunitdec : String read fNr_Vlunitdec write SetNr_Vlunitdec;
    property Nr_Qtunitdec : String read fNr_Qtunitdec write SetNr_Qtunitdec;
    property Nm_Job : String read fNm_Job write SetNm_Job;
    property In_Quebranf : String read fIn_Quebranf write SetIn_Quebranf;
    property In_Agrupa_Grupo : String read fIn_Agrupa_Grupo write SetIn_Agrupa_Grupo;
    property Tp_Codproduto : String read fTp_Codproduto write SetTp_Codproduto;
  end;

  TGer_ModnfcList = class(TmCollection)
  private
    function GetItem(Index: Integer): TGer_Modnfc;
    procedure SetItem(Index: Integer; Value: TGer_Modnfc);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TGer_Modnfc;
    property Items[Index: Integer]: TGer_Modnfc read GetItem write SetItem; default;
  end;

implementation

{ TGer_Modnfc }

constructor TGer_Modnfc.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TGer_Modnfc.Destroy;
begin

  inherited;
end;

{ TGer_ModnfcList }

constructor TGer_ModnfcList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TGer_Modnfc);
end;

function TGer_ModnfcList.Add: TGer_Modnfc;
begin
  Result := TGer_Modnfc(inherited Add);
  Result.create;
end;

function TGer_ModnfcList.GetItem(Index: Integer): TGer_Modnfc;
begin
  Result := TGer_Modnfc(inherited GetItem(Index));
end;

procedure TGer_ModnfcList.SetItem(Index: Integer; Value: TGer_Modnfc);
begin
  inherited SetItem(Index, Value);
end;

end.