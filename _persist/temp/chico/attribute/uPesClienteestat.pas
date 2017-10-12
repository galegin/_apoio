unit uPesClienteestat;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_CLIENTEESTAT')]
  TPes_Clienteestat = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_EMPRESA', tfKey)]
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    [Campo('CD_CLIENTE', tfKey)]
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_GRUPOEMPRESA', tfReq)]
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('QT_ATRSMEDIO', tfNul)]
    property Qt_Atrsmedio : String read fQt_Atrsmedio write fQt_Atrsmedio;
    [Campo('QT_ATRSMAXIMO', tfNul)]
    property Qt_Atrsmaximo : String read fQt_Atrsmaximo write fQt_Atrsmaximo;
    [Campo('QT_CHEQUEDEVOLV', tfNul)]
    property Qt_Chequedevolv : String read fQt_Chequedevolv write fQt_Chequedevolv;
    [Campo('QT_PARCELAPAGA', tfNul)]
    property Qt_Parcelapaga : String read fQt_Parcelapaga write fQt_Parcelapaga;
    [Campo('QT_PARCELAPGCART', tfNul)]
    property Qt_Parcelapgcart : String read fQt_Parcelapgcart write fQt_Parcelapgcart;
    [Campo('QT_COMPRAS', tfNul)]
    property Qt_Compras : String read fQt_Compras write fQt_Compras;
    [Campo('VL_ACUMDEBITO', tfNul)]
    property Vl_Acumdebito : String read fVl_Acumdebito write fVl_Acumdebito;
    [Campo('VL_FATORLIMITE', tfNul)]
    property Vl_Fatorlimite : String read fVl_Fatorlimite write fVl_Fatorlimite;
    [Campo('VL_MAIORCOMPRA', tfNul)]
    property Vl_Maiorcompra : String read fVl_Maiorcompra write fVl_Maiorcompra;
    [Campo('VL_PRIMCOMPRA', tfNul)]
    property Vl_Primcompra : String read fVl_Primcompra write fVl_Primcompra;
    [Campo('VL_ULTCOMPRA', tfNul)]
    property Vl_Ultcompra : String read fVl_Ultcompra write fVl_Ultcompra;
    [Campo('DT_ACUMDEBITO', tfNul)]
    property Dt_Acumdebito : String read fDt_Acumdebito write fDt_Acumdebito;
    [Campo('DT_ENTRPROTESTO', tfNul)]
    property Dt_Entrprotesto : String read fDt_Entrprotesto write fDt_Entrprotesto;
    [Campo('DT_SAIDAPROTESTO', tfNul)]
    property Dt_Saidaprotesto : String read fDt_Saidaprotesto write fDt_Saidaprotesto;
    [Campo('DT_MAIORCOMPRA', tfNul)]
    property Dt_Maiorcompra : String read fDt_Maiorcompra write fDt_Maiorcompra;
    [Campo('DT_PRIMCOMPRA', tfNul)]
    property Dt_Primcompra : String read fDt_Primcompra write fDt_Primcompra;
    [Campo('DT_ULTCARTA', tfNul)]
    property Dt_Ultcarta : String read fDt_Ultcarta write fDt_Ultcarta;
    [Campo('DT_ULTCOMPRA', tfNul)]
    property Dt_Ultcompra : String read fDt_Ultcompra write fDt_Ultcompra;
    [Campo('DT_ULTCONSULTA', tfNul)]
    property Dt_Ultconsulta : String read fDt_Ultconsulta write fDt_Ultconsulta;
    [Campo('DT_ULTEMAIL', tfNul)]
    property Dt_Ultemail : String read fDt_Ultemail write fDt_Ultemail;
    [Campo('NM_EMPRCONSULTA', tfNul)]
    property Nm_Emprconsulta : String read fNm_Emprconsulta write fNm_Emprconsulta;
    [Campo('VL_COMPRASTOTAL', tfNul)]
    property Vl_Comprastotal : String read fVl_Comprastotal write fVl_Comprastotal;
  end;

  TPes_Clienteestats = class(TList<Pes_Clienteestat>);

implementation

{ TPes_Clienteestat }

constructor TPes_Clienteestat.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Clienteestat.Destroy;
begin

  inherited;
end;

end.