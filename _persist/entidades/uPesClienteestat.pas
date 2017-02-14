unit uPesClienteestat;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Clienteestat = class;
  TPes_ClienteestatClass = class of TPes_Clienteestat;

  TPes_ClienteestatList = class;
  TPes_ClienteestatListClass = class of TPes_ClienteestatList;

  TPes_Clienteestat = class(TcCollectionItem)
  private
    fCd_Empresa: Real;
    fCd_Cliente: Real;
    fU_Version: String;
    fCd_Grupoempresa: Real;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fQt_Atrsmedio: Real;
    fQt_Atrsmaximo: Real;
    fQt_Chequedevolv: Real;
    fQt_Parcelapaga: Real;
    fQt_Parcelapgcart: Real;
    fQt_Compras: Real;
    fVl_Acumdebito: Real;
    fVl_Fatorlimite: Real;
    fVl_Maiorcompra: Real;
    fVl_Primcompra: Real;
    fVl_Ultcompra: Real;
    fDt_Acumdebito: TDateTime;
    fDt_Entrprotesto: TDateTime;
    fDt_Saidaprotesto: TDateTime;
    fDt_Maiorcompra: TDateTime;
    fDt_Primcompra: TDateTime;
    fDt_Ultcarta: TDateTime;
    fDt_Ultcompra: TDateTime;
    fDt_Ultconsulta: TDateTime;
    fDt_Ultemail: TDateTime;
    fNm_Emprconsulta: String;
    fVl_Comprastotal: Real;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Empresa : Real read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : Real read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : Real read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Qt_Atrsmedio : Real read fQt_Atrsmedio write fQt_Atrsmedio;
    property Qt_Atrsmaximo : Real read fQt_Atrsmaximo write fQt_Atrsmaximo;
    property Qt_Chequedevolv : Real read fQt_Chequedevolv write fQt_Chequedevolv;
    property Qt_Parcelapaga : Real read fQt_Parcelapaga write fQt_Parcelapaga;
    property Qt_Parcelapgcart : Real read fQt_Parcelapgcart write fQt_Parcelapgcart;
    property Qt_Compras : Real read fQt_Compras write fQt_Compras;
    property Vl_Acumdebito : Real read fVl_Acumdebito write fVl_Acumdebito;
    property Vl_Fatorlimite : Real read fVl_Fatorlimite write fVl_Fatorlimite;
    property Vl_Maiorcompra : Real read fVl_Maiorcompra write fVl_Maiorcompra;
    property Vl_Primcompra : Real read fVl_Primcompra write fVl_Primcompra;
    property Vl_Ultcompra : Real read fVl_Ultcompra write fVl_Ultcompra;
    property Dt_Acumdebito : TDateTime read fDt_Acumdebito write fDt_Acumdebito;
    property Dt_Entrprotesto : TDateTime read fDt_Entrprotesto write fDt_Entrprotesto;
    property Dt_Saidaprotesto : TDateTime read fDt_Saidaprotesto write fDt_Saidaprotesto;
    property Dt_Maiorcompra : TDateTime read fDt_Maiorcompra write fDt_Maiorcompra;
    property Dt_Primcompra : TDateTime read fDt_Primcompra write fDt_Primcompra;
    property Dt_Ultcarta : TDateTime read fDt_Ultcarta write fDt_Ultcarta;
    property Dt_Ultcompra : TDateTime read fDt_Ultcompra write fDt_Ultcompra;
    property Dt_Ultconsulta : TDateTime read fDt_Ultconsulta write fDt_Ultconsulta;
    property Dt_Ultemail : TDateTime read fDt_Ultemail write fDt_Ultemail;
    property Nm_Emprconsulta : String read fNm_Emprconsulta write fNm_Emprconsulta;
    property Vl_Comprastotal : Real read fVl_Comprastotal write fVl_Comprastotal;
  end;

  TPes_ClienteestatList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Clienteestat;
    procedure SetItem(Index: Integer; Value: TPes_Clienteestat);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Clienteestat;
    property Items[Index: Integer]: TPes_Clienteestat read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Clienteestat }

constructor TPes_Clienteestat.Create;
begin

end;

destructor TPes_Clienteestat.Destroy;
begin

  inherited;
end;

{ TPes_ClienteestatList }

constructor TPes_ClienteestatList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Clienteestat);
end;

function TPes_ClienteestatList.Add: TPes_Clienteestat;
begin
  Result := TPes_Clienteestat(inherited Add);
  Result.create;
end;

function TPes_ClienteestatList.GetItem(Index: Integer): TPes_Clienteestat;
begin
  Result := TPes_Clienteestat(inherited GetItem(Index));
end;

procedure TPes_ClienteestatList.SetItem(Index: Integer; Value: TPes_Clienteestat);
begin
  inherited SetItem(Index, Value);
end;

end.