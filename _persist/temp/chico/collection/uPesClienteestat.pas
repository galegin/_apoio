unit uPesClienteestat;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Clienteestat = class;
  TPes_ClienteestatClass = class of TPes_Clienteestat;

  TPes_ClienteestatList = class;
  TPes_ClienteestatListClass = class of TPes_ClienteestatList;

  TPes_Clienteestat = class(TmCollectionItem)
  private
    fCd_Empresa: String;
    fCd_Cliente: String;
    fU_Version: String;
    fCd_Grupoempresa: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fQt_Atrsmedio: String;
    fQt_Atrsmaximo: String;
    fQt_Chequedevolv: String;
    fQt_Parcelapaga: String;
    fQt_Parcelapgcart: String;
    fQt_Compras: String;
    fVl_Acumdebito: String;
    fVl_Fatorlimite: String;
    fVl_Maiorcompra: String;
    fVl_Primcompra: String;
    fVl_Ultcompra: String;
    fDt_Acumdebito: String;
    fDt_Entrprotesto: String;
    fDt_Saidaprotesto: String;
    fDt_Maiorcompra: String;
    fDt_Primcompra: String;
    fDt_Ultcarta: String;
    fDt_Ultcompra: String;
    fDt_Ultconsulta: String;
    fDt_Ultemail: String;
    fNm_Emprconsulta: String;
    fVl_Comprastotal: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Empresa : String read fCd_Empresa write SetCd_Empresa;
    property Cd_Cliente : String read fCd_Cliente write SetCd_Cliente;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write SetCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Qt_Atrsmedio : String read fQt_Atrsmedio write SetQt_Atrsmedio;
    property Qt_Atrsmaximo : String read fQt_Atrsmaximo write SetQt_Atrsmaximo;
    property Qt_Chequedevolv : String read fQt_Chequedevolv write SetQt_Chequedevolv;
    property Qt_Parcelapaga : String read fQt_Parcelapaga write SetQt_Parcelapaga;
    property Qt_Parcelapgcart : String read fQt_Parcelapgcart write SetQt_Parcelapgcart;
    property Qt_Compras : String read fQt_Compras write SetQt_Compras;
    property Vl_Acumdebito : String read fVl_Acumdebito write SetVl_Acumdebito;
    property Vl_Fatorlimite : String read fVl_Fatorlimite write SetVl_Fatorlimite;
    property Vl_Maiorcompra : String read fVl_Maiorcompra write SetVl_Maiorcompra;
    property Vl_Primcompra : String read fVl_Primcompra write SetVl_Primcompra;
    property Vl_Ultcompra : String read fVl_Ultcompra write SetVl_Ultcompra;
    property Dt_Acumdebito : String read fDt_Acumdebito write SetDt_Acumdebito;
    property Dt_Entrprotesto : String read fDt_Entrprotesto write SetDt_Entrprotesto;
    property Dt_Saidaprotesto : String read fDt_Saidaprotesto write SetDt_Saidaprotesto;
    property Dt_Maiorcompra : String read fDt_Maiorcompra write SetDt_Maiorcompra;
    property Dt_Primcompra : String read fDt_Primcompra write SetDt_Primcompra;
    property Dt_Ultcarta : String read fDt_Ultcarta write SetDt_Ultcarta;
    property Dt_Ultcompra : String read fDt_Ultcompra write SetDt_Ultcompra;
    property Dt_Ultconsulta : String read fDt_Ultconsulta write SetDt_Ultconsulta;
    property Dt_Ultemail : String read fDt_Ultemail write SetDt_Ultemail;
    property Nm_Emprconsulta : String read fNm_Emprconsulta write SetNm_Emprconsulta;
    property Vl_Comprastotal : String read fVl_Comprastotal write SetVl_Comprastotal;
  end;

  TPes_ClienteestatList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Clienteestat;
    procedure SetItem(Index: Integer; Value: TPes_Clienteestat);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Clienteestat;
    property Items[Index: Integer]: TPes_Clienteestat read GetItem write SetItem; default;
  end;

implementation

{ TPes_Clienteestat }

constructor TPes_Clienteestat.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Clienteestat.Destroy;
begin

  inherited;
end;

{ TPes_ClienteestatList }

constructor TPes_ClienteestatList.Create(AOwner: TPersistentCollection);
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