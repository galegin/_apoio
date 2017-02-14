unit uFcpDupimposto;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcp_Dupimposto = class;
  TFcp_DupimpostoClass = class of TFcp_Dupimposto;

  TFcp_DupimpostoList = class;
  TFcp_DupimpostoListClass = class of TFcp_DupimpostoList;

  TFcp_Dupimposto = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Fornecedor: Real;
    fNr_Duplicata: Real;
    fNr_Parcela: Real;
    fCd_Imposto: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fCd_Empresaimp: Real;
    fCd_Fornecimp: Real;
    fNr_Duplicataimp: Real;
    fPr_Aliquota: Real;
    fVl_Imposto: Real;
    fNr_Parcelaimp: Real;
    fTp_Situacao: Real;
    fCd_Empliq: Real;
    fDt_Liq: TDateTime;
    fNr_Seqliq: Real;
    fVl_Basecalcimp: Real;
    fPr_Basecalc: Real;
    fVl_Retencaoteto: Real;
    fTp_Retencao: Real;
    fCd_Componente: String;
    fTp_Localret: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Fornecedor : Real read fCd_Fornecedor write fCd_Fornecedor;
    property Nr_Duplicata : Real read fNr_Duplicata write fNr_Duplicata;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property Cd_Imposto : Real read fCd_Imposto write fCd_Imposto;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Cd_Empresaimp : Real read fCd_Empresaimp write fCd_Empresaimp;
    property Cd_Fornecimp : Real read fCd_Fornecimp write fCd_Fornecimp;
    property Nr_Duplicataimp : Real read fNr_Duplicataimp write fNr_Duplicataimp;
    property Pr_Aliquota : Real read fPr_Aliquota write fPr_Aliquota;
    property Vl_Imposto : Real read fVl_Imposto write fVl_Imposto;
    property Nr_Parcelaimp : Real read fNr_Parcelaimp write fNr_Parcelaimp;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property Cd_Empliq : Real read fCd_Empliq write fCd_Empliq;
    property Dt_Liq : TDateTime read fDt_Liq write fDt_Liq;
    property Nr_Seqliq : Real read fNr_Seqliq write fNr_Seqliq;
    property Vl_Basecalcimp : Real read fVl_Basecalcimp write fVl_Basecalcimp;
    property Pr_Basecalc : Real read fPr_Basecalc write fPr_Basecalc;
    property Vl_Retencaoteto : Real read fVl_Retencaoteto write fVl_Retencaoteto;
    property Tp_Retencao : Real read fTp_Retencao write fTp_Retencao;
    property Cd_Componente : String read fCd_Componente write fCd_Componente;
    property Tp_Localret : String read fTp_Localret write fTp_Localret;
  end;

  TFcp_DupimpostoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcp_Dupimposto;
    procedure SetItem(Index: Integer; Value: TFcp_Dupimposto);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcp_Dupimposto;
    property Items[Index: Integer]: TFcp_Dupimposto read GetItem write SetItem; default;
  end;
  
implementation

{ TFcp_Dupimposto }

constructor TFcp_Dupimposto.Create;
begin

end;

destructor TFcp_Dupimposto.Destroy;
begin

  inherited;
end;

{ TFcp_DupimpostoList }

constructor TFcp_DupimpostoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcp_Dupimposto);
end;

function TFcp_DupimpostoList.Add: TFcp_Dupimposto;
begin
  Result := TFcp_Dupimposto(inherited Add);
  Result.create;
end;

function TFcp_DupimpostoList.GetItem(Index: Integer): TFcp_Dupimposto;
begin
  Result := TFcp_Dupimposto(inherited GetItem(Index));
end;

procedure TFcp_DupimpostoList.SetItem(Index: Integer; Value: TFcp_Dupimposto);
begin
  inherited SetItem(Index, Value);
end;

end.