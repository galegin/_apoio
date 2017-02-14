unit uFcrComissao;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TFcr_Comissao = class;
  TFcr_ComissaoClass = class of TFcr_Comissao;

  TFcr_ComissaoList = class;
  TFcr_ComissaoListClass = class of TFcr_ComissaoList;

  TFcr_Comissao = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fNr_Fatura: Real;
    fNr_Parcela: Real;
    fCd_Pescomis: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fPr_Fatura: Real;
    fIn_Recpago: String;
    fIn_Fatpago: String;
    fPr_Comissaofat: Real;
    fPr_Comissaorec: Real;
    fVl_Comissaofat: Real;
    fVl_Comissaorec: Real;
    fCd_Tipocomis: Real;
    fIn_Repasse: String;
    fTp_Situacao: Real;
    fCd_Tipoclass: Real;
    fCd_Class: String;
    fVl_Comissfechafat: Real;
    fVl_Comissfecharec: Real;
    fVl_Faturafechafat: Real;
    fVl_Faturafecharec: Real;
    fPr_Comisadicfat: Real;
    fVl_Comisadicfat: Real;
    fPr_Comisadicrec: Real;
    fVl_Comisadicrec: Real;
    fIn_Adicrecpago: String;
    fIn_Adicfatpago: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property Nr_Fatura : Real read fNr_Fatura write fNr_Fatura;
    property Nr_Parcela : Real read fNr_Parcela write fNr_Parcela;
    property Cd_Pescomis : Real read fCd_Pescomis write fCd_Pescomis;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Pr_Fatura : Real read fPr_Fatura write fPr_Fatura;
    property In_Recpago : String read fIn_Recpago write fIn_Recpago;
    property In_Fatpago : String read fIn_Fatpago write fIn_Fatpago;
    property Pr_Comissaofat : Real read fPr_Comissaofat write fPr_Comissaofat;
    property Pr_Comissaorec : Real read fPr_Comissaorec write fPr_Comissaorec;
    property Vl_Comissaofat : Real read fVl_Comissaofat write fVl_Comissaofat;
    property Vl_Comissaorec : Real read fVl_Comissaorec write fVl_Comissaorec;
    property Cd_Tipocomis : Real read fCd_Tipocomis write fCd_Tipocomis;
    property In_Repasse : String read fIn_Repasse write fIn_Repasse;
    property Tp_Situacao : Real read fTp_Situacao write fTp_Situacao;
    property Cd_Tipoclass : Real read fCd_Tipoclass write fCd_Tipoclass;
    property Cd_Class : String read fCd_Class write fCd_Class;
    property Vl_Comissfechafat : Real read fVl_Comissfechafat write fVl_Comissfechafat;
    property Vl_Comissfecharec : Real read fVl_Comissfecharec write fVl_Comissfecharec;
    property Vl_Faturafechafat : Real read fVl_Faturafechafat write fVl_Faturafechafat;
    property Vl_Faturafecharec : Real read fVl_Faturafecharec write fVl_Faturafecharec;
    property Pr_Comisadicfat : Real read fPr_Comisadicfat write fPr_Comisadicfat;
    property Vl_Comisadicfat : Real read fVl_Comisadicfat write fVl_Comisadicfat;
    property Pr_Comisadicrec : Real read fPr_Comisadicrec write fPr_Comisadicrec;
    property Vl_Comisadicrec : Real read fVl_Comisadicrec write fVl_Comisadicrec;
    property In_Adicrecpago : String read fIn_Adicrecpago write fIn_Adicrecpago;
    property In_Adicfatpago : String read fIn_Adicfatpago write fIn_Adicfatpago;
  end;

  TFcr_ComissaoList = class(TcCollection)
  private
    function GetItem(Index: Integer): TFcr_Comissao;
    procedure SetItem(Index: Integer; Value: TFcr_Comissao);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TFcr_Comissao;
    property Items[Index: Integer]: TFcr_Comissao read GetItem write SetItem; default;
  end;
  
implementation

{ TFcr_Comissao }

constructor TFcr_Comissao.Create;
begin

end;

destructor TFcr_Comissao.Destroy;
begin

  inherited;
end;

{ TFcr_ComissaoList }

constructor TFcr_ComissaoList.Create(AOwner: TPersistent);
begin
  inherited Create(TFcr_Comissao);
end;

function TFcr_ComissaoList.Add: TFcr_Comissao;
begin
  Result := TFcr_Comissao(inherited Add);
  Result.create;
end;

function TFcr_ComissaoList.GetItem(Index: Integer): TFcr_Comissao;
begin
  Result := TFcr_Comissao(inherited GetItem(Index));
end;

procedure TFcr_ComissaoList.SetItem(Index: Integer; Value: TFcr_Comissao);
begin
  inherited SetItem(Index, Value);
end;

end.