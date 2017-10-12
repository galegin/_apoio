unit uPesPfadic;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_PFADIC')]
  TPes_Pfadic = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('TP_ESCOLARIDADE', tfNul)]
    property Tp_Escolaridade : String read fTp_Escolaridade write fTp_Escolaridade;
    [Campo('QT_FILHOS', tfNul)]
    property Qt_Filhos : String read fQt_Filhos write fQt_Filhos;
    [Campo('QT_DEPENDENTES', tfNul)]
    property Qt_Dependentes : String read fQt_Dependentes write fQt_Dependentes;
    [Campo('QT_RESANTMESES', tfNul)]
    property Qt_Resantmeses : String read fQt_Resantmeses write fQt_Resantmeses;
    [Campo('QT_TRAANTMESES', tfNul)]
    property Qt_Traantmeses : String read fQt_Traantmeses write fQt_Traantmeses;
    [Campo('DS_TRAANTLOCAL', tfNul)]
    property Ds_Traantlocal : String read fDs_Traantlocal write fDs_Traantlocal;
    [Campo('DT_RESIDEDESDE', tfNul)]
    property Dt_Residedesde : String read fDt_Residedesde write fDt_Residedesde;
    [Campo('TP_CASA', tfNul)]
    property Tp_Casa : String read fTp_Casa write fTp_Casa;
    [Campo('TP_CARRO', tfNul)]
    property Tp_Carro : String read fTp_Carro write fTp_Carro;
    [Campo('NR_ESCORE', tfNul)]
    property Nr_Escore : String read fNr_Escore write fNr_Escore;
    [Campo('NR_RISCO', tfNul)]
    property Nr_Risco : String read fNr_Risco write fNr_Risco;
    [Campo('DT_ATUALIZSPC', tfNul)]
    property Dt_Atualizspc : String read fDt_Atualizspc write fDt_Atualizspc;
    [Campo('IN_AMBULANTE', tfNul)]
    property In_Ambulante : String read fIn_Ambulante write fIn_Ambulante;
    [Campo('NR_AMBULANTE', tfNul)]
    property Nr_Ambulante : String read fNr_Ambulante write fNr_Ambulante;
    [Campo('TP_RG', tfNul)]
    property Tp_Rg : String read fTp_Rg write fTp_Rg;
    [Campo('DT_EXPEDICAORG', tfNul)]
    property Dt_Expedicaorg : String read fDt_Expedicaorg write fDt_Expedicaorg;
    [Campo('DS_PASSAPORTE', tfNul)]
    property Ds_Passaporte : String read fDs_Passaporte write fDs_Passaporte;
    [Campo('CD_PAISPASSAPORTE', tfNul)]
    property Cd_Paispassaporte : String read fCd_Paispassaporte write fCd_Paispassaporte;
    [Campo('NR_CNH', tfNul)]
    property Nr_Cnh : String read fNr_Cnh write fNr_Cnh;
    [Campo('DT_VALIDADECNH', tfNul)]
    property Dt_Validadecnh : String read fDt_Validadecnh write fDt_Validadecnh;
    [Campo('DT_PRIMEIRAHAB', tfNul)]
    property Dt_Primeirahab : String read fDt_Primeirahab write fDt_Primeirahab;
    [Campo('DS_ORGAOCNH', tfNul)]
    property Ds_Orgaocnh : String read fDs_Orgaocnh write fDs_Orgaocnh;
    [Campo('TP_CATEGORIACNH', tfNul)]
    property Tp_Categoriacnh : String read fTp_Categoriacnh write fTp_Categoriacnh;
    [Campo('NR_TITULOELEITOR', tfNul)]
    property Nr_Tituloeleitor : String read fNr_Tituloeleitor write fNr_Tituloeleitor;
    [Campo('NR_ZONAELEITOR', tfNul)]
    property Nr_Zonaeleitor : String read fNr_Zonaeleitor write fNr_Zonaeleitor;
    [Campo('NR_SECAOELEITOR', tfNul)]
    property Nr_Secaoeleitor : String read fNr_Secaoeleitor write fNr_Secaoeleitor;
    [Campo('TP_CERTIFICADOMILITAR', tfNul)]
    property Tp_Certificadomilitar : String read fTp_Certificadomilitar write fTp_Certificadomilitar;
    [Campo('TP_CATEGORIAMILITAR', tfNul)]
    property Tp_Categoriamilitar : String read fTp_Categoriamilitar write fTp_Categoriamilitar;
    [Campo('DS_DISPENSAMILITAR', tfNul)]
    property Ds_Dispensamilitar : String read fDs_Dispensamilitar write fDs_Dispensamilitar;
    [Campo('NR_NIT', tfNul)]
    property Nr_Nit : String read fNr_Nit write fNr_Nit;
    [Campo('DS_SIGLAUFCTPS', tfNul)]
    property Ds_Siglaufctps : String read fDs_Siglaufctps write fDs_Siglaufctps;
    [Campo('IN_TRABINFORMAL', tfNul)]
    property In_Trabinformal : String read fIn_Trabinformal write fIn_Trabinformal;
    [Campo('DT_CASAMENTO', tfNul)]
    property Dt_Casamento : String read fDt_Casamento write fDt_Casamento;
    [Campo('TP_REGCASAMENTO', tfNul)]
    property Tp_Regcasamento : String read fTp_Regcasamento write fTp_Regcasamento;
    [Campo('NR_PIS', tfNul)]
    property Nr_Pis : String read fNr_Pis write fNr_Pis;
    [Campo('DT_EMISSAOPIS', tfNul)]
    property Dt_Emissaopis : String read fDt_Emissaopis write fDt_Emissaopis;
    [Campo('DS_SIGLAUFPIS', tfNul)]
    property Ds_Siglaufpis : String read fDs_Siglaufpis write fDs_Siglaufpis;
    [Campo('DT_EMISSAOCTPS', tfNul)]
    property Dt_Emissaoctps : String read fDt_Emissaoctps write fDt_Emissaoctps;
    [Campo('NR_INSCPRODRURAL', tfNul)]
    property Nr_Inscprodrural : String read fNr_Inscprodrural write fNr_Inscprodrural;
    [Campo('DS_UFPRODRURAL', tfNul)]
    property Ds_Ufprodrural : String read fDs_Ufprodrural write fDs_Ufprodrural;
  end;

  TPes_Pfadics = class(TList<Pes_Pfadic>);

implementation

{ TPes_Pfadic }

constructor TPes_Pfadic.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pfadic.Destroy;
begin

  inherited;
end;

end.