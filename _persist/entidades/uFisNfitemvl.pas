unit uFisNfitemvl;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFis_Nfitemvl = class;
  TFis_NfitemvlClass = class of TFis_Nfitemvl;

  TFis_NfitemvlList = class;
  TFis_NfitemvlListClass = class of TFis_NfitemvlList;

  TFis_Nfitemvl = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fNr_Fatura: Real;
    fDt_Fatura: TDateTime;
    fNr_Item: Real;
    fCd_Produto: Real;
    fTp_Valor: String;
    fCd_Valor: Real;
    fU_Version: String;
    fCd_Empfat: Real;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Atualizacao: Real;
    fVl_Unitarioorig: Real;
    fVl_Unitario: Real;
    fPr_Desconto: Real;
    fPr_Descontocab: Real;
    fIn_Padrao: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Dt_Fatura : TDateTime read fDt_Fatura write fDt_Fatura;
    property Nr_Item : Real read fNr_Item write fNr_Item;
    property Cd_Produto : Real read fCd_Produto write fCd_Produto;
    property Tp_Valor : String read fTp_Valor write fTp_Valor;
    property Cd_Valor : Real read fCd_Valor write fCd_Valor;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Empfat : Real read fCd_Empfat write fCd_Empfat;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Atualizacao : Real read fTp_Atualizacao write fTp_Atualizacao;
    property Vl_Unitarioorig : Real read fVl_Unitarioorig write fVl_Unitarioorig;
    property Vl_Unitario : Real read fVl_Unitario write fVl_Unitario;
    property Pr_Desconto : Real read fPr_Desconto write fPr_Desconto;
    property Pr_Descontocab : Real read fPr_Descontocab write fPr_Descontocab;
    property In_Padrao : String read fIn_Padrao write fIn_Padrao;
  end;

  TFis_NfitemvlList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFis_Nfitemvl;
    procedure SetItem(Index: Integer; Value: TFis_Nfitemvl);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFis_Nfitemvl;
    property Items[Index: Integer]: TFis_Nfitemvl read GetItem write SetItem; default;
  end;
  
implementation

{ TFis_Nfitemvl }

constructor TFis_Nfitemvl.Create;
begin

end;

destructor TFis_Nfitemvl.Destroy;
begin

  inherited;
end;

{ TFis_NfitemvlList }

constructor TFis_NfitemvlList.Create(AOwner: TPersistent);
begin
  inherited Create(TFis_Nfitemvl);
end;

function TFis_NfitemvlList.Add: TFis_Nfitemvl;
begin
  Result := TFis_Nfitemvl(inherited Add);
  Result.create;
end;

function TFis_NfitemvlList.GetItem(Index: Integer): TFis_Nfitemvl;
begin
  Result := TFis_Nfitemvl(inherited GetItem(Index));
end;

procedure TFis_NfitemvlList.SetItem(Index: Integer; Value: TFis_Nfitemvl);
begin
  inherited SetItem(Index, Value);
end;

end.