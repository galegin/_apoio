unit uGerModnfc;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TGer_Modnfc = class;
  TGer_ModnfcClass = class of TGer_Modnfc;

  TGer_ModnfcList = class;
  TGer_ModnfcListClass = class of TGer_ModnfcList;

  TGer_Modnfc = class(TcCollectionItem)
  private
    fCd_Modelonf: Real;
    fU_Version: String;
    fCd_Serie: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fDs_Modelonf: String;
    fNr_Colunas: Real;
    fNr_Linhas: Real;
    fNr_Itens: Real;
    fNr_Vlunitdec: Real;
    fNr_Qtunitdec: Real;
    fNm_Job: String;
    fIn_Quebranf: String;
    fIn_Agrupa_Grupo: String;
    fTp_Codproduto: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Modelonf : Real read fCd_Modelonf write fCd_Modelonf;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Serie : Real read fCd_Serie write fCd_Serie;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Ds_Modelonf : String read fDs_Modelonf write fDs_Modelonf;
    property Nr_Colunas : Real read fNr_Colunas write fNr_Colunas;
    property Nr_Linhas : Real read fNr_Linhas write fNr_Linhas;
    property Nr_Itens : Real read fNr_Itens write fNr_Itens;
    property Nr_Vlunitdec : Real read fNr_Vlunitdec write fNr_Vlunitdec;
    property Nr_Qtunitdec : Real read fNr_Qtunitdec write fNr_Qtunitdec;
    property Nm_Job : String read fNm_Job write fNm_Job;
    property In_Quebranf : String read fIn_Quebranf write fIn_Quebranf;
    property In_Agrupa_Grupo : String read fIn_Agrupa_Grupo write fIn_Agrupa_Grupo;
    property Tp_Codproduto : Real read fTp_Codproduto write fTp_Codproduto;
  end;

  TGer_ModnfcList = class(TcCollection)
  private
    function GetItem(Index: Integer): TGer_Modnfc;
    procedure SetItem(Index: Integer; Value: TGer_Modnfc);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGer_Modnfc;
    property Items[Index: Integer]: TGer_Modnfc read GetItem write SetItem; default;
  end;
  
implementation

{ TGer_Modnfc }

constructor TGer_Modnfc.Create;
begin

end;

destructor TGer_Modnfc.Destroy;
begin

  inherited;
end;

{ TGer_ModnfcList }

constructor TGer_ModnfcList.Create(AOwner: TPersistent);
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