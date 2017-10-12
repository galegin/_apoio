unit uPesClienteestat;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Clienteestat = class(TmMapping)
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Cliente : String read fCd_Cliente write fCd_Cliente;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Grupoempresa : String read fCd_Grupoempresa write fCd_Grupoempresa;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Qt_Atrsmedio : String read fQt_Atrsmedio write fQt_Atrsmedio;
    property Qt_Atrsmaximo : String read fQt_Atrsmaximo write fQt_Atrsmaximo;
    property Qt_Chequedevolv : String read fQt_Chequedevolv write fQt_Chequedevolv;
    property Qt_Parcelapaga : String read fQt_Parcelapaga write fQt_Parcelapaga;
    property Qt_Parcelapgcart : String read fQt_Parcelapgcart write fQt_Parcelapgcart;
    property Qt_Compras : String read fQt_Compras write fQt_Compras;
    property Vl_Acumdebito : String read fVl_Acumdebito write fVl_Acumdebito;
    property Vl_Fatorlimite : String read fVl_Fatorlimite write fVl_Fatorlimite;
    property Vl_Maiorcompra : String read fVl_Maiorcompra write fVl_Maiorcompra;
    property Vl_Primcompra : String read fVl_Primcompra write fVl_Primcompra;
    property Vl_Ultcompra : String read fVl_Ultcompra write fVl_Ultcompra;
    property Dt_Acumdebito : String read fDt_Acumdebito write fDt_Acumdebito;
    property Dt_Entrprotesto : String read fDt_Entrprotesto write fDt_Entrprotesto;
    property Dt_Saidaprotesto : String read fDt_Saidaprotesto write fDt_Saidaprotesto;
    property Dt_Maiorcompra : String read fDt_Maiorcompra write fDt_Maiorcompra;
    property Dt_Primcompra : String read fDt_Primcompra write fDt_Primcompra;
    property Dt_Ultcarta : String read fDt_Ultcarta write fDt_Ultcarta;
    property Dt_Ultcompra : String read fDt_Ultcompra write fDt_Ultcompra;
    property Dt_Ultconsulta : String read fDt_Ultconsulta write fDt_Ultconsulta;
    property Dt_Ultemail : String read fDt_Ultemail write fDt_Ultemail;
    property Nm_Emprconsulta : String read fNm_Emprconsulta write fNm_Emprconsulta;
    property Vl_Comprastotal : String read fVl_Comprastotal write fVl_Comprastotal;
  end;

  TPes_Clienteestats = class(TList)
  public
    function Add: TPes_Clienteestat; overload;
  end;

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

//--

function TPes_Clienteestat.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_CLIENTEESTAT';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Cliente', 'CD_CLIENTE', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Grupoempresa', 'CD_GRUPOEMPRESA', tfReq);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Qt_Atrsmedio', 'QT_ATRSMEDIO', tfNul);
    Add('Qt_Atrsmaximo', 'QT_ATRSMAXIMO', tfNul);
    Add('Qt_Chequedevolv', 'QT_CHEQUEDEVOLV', tfNul);
    Add('Qt_Parcelapaga', 'QT_PARCELAPAGA', tfNul);
    Add('Qt_Parcelapgcart', 'QT_PARCELAPGCART', tfNul);
    Add('Qt_Compras', 'QT_COMPRAS', tfNul);
    Add('Vl_Acumdebito', 'VL_ACUMDEBITO', tfNul);
    Add('Vl_Fatorlimite', 'VL_FATORLIMITE', tfNul);
    Add('Vl_Maiorcompra', 'VL_MAIORCOMPRA', tfNul);
    Add('Vl_Primcompra', 'VL_PRIMCOMPRA', tfNul);
    Add('Vl_Ultcompra', 'VL_ULTCOMPRA', tfNul);
    Add('Dt_Acumdebito', 'DT_ACUMDEBITO', tfNul);
    Add('Dt_Entrprotesto', 'DT_ENTRPROTESTO', tfNul);
    Add('Dt_Saidaprotesto', 'DT_SAIDAPROTESTO', tfNul);
    Add('Dt_Maiorcompra', 'DT_MAIORCOMPRA', tfNul);
    Add('Dt_Primcompra', 'DT_PRIMCOMPRA', tfNul);
    Add('Dt_Ultcarta', 'DT_ULTCARTA', tfNul);
    Add('Dt_Ultcompra', 'DT_ULTCOMPRA', tfNul);
    Add('Dt_Ultconsulta', 'DT_ULTCONSULTA', tfNul);
    Add('Dt_Ultemail', 'DT_ULTEMAIL', tfNul);
    Add('Nm_Emprconsulta', 'NM_EMPRCONSULTA', tfNul);
    Add('Vl_Comprastotal', 'VL_COMPRASTOTAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Clienteestats }

function TPes_Clienteestats.Add: TPes_Clienteestat;
begin
  Result := TPes_Clienteestat.Create(nil);
  Self.Add(Result);
end;

end.