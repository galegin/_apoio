unit uPesPfadic;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPes_Pfadic = class(TmMapping)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fTp_Escolaridade: String;
    fQt_Filhos: String;
    fQt_Dependentes: String;
    fQt_Resantmeses: String;
    fQt_Traantmeses: String;
    fDs_Traantlocal: String;
    fDt_Residedesde: String;
    fTp_Casa: String;
    fTp_Carro: String;
    fNr_Escore: String;
    fNr_Risco: String;
    fDt_Atualizspc: String;
    fIn_Ambulante: String;
    fNr_Ambulante: String;
    fTp_Rg: String;
    fDt_Expedicaorg: String;
    fDs_Passaporte: String;
    fCd_Paispassaporte: String;
    fNr_Cnh: String;
    fDt_Validadecnh: String;
    fDt_Primeirahab: String;
    fDs_Orgaocnh: String;
    fTp_Categoriacnh: String;
    fNr_Tituloeleitor: String;
    fNr_Zonaeleitor: String;
    fNr_Secaoeleitor: String;
    fTp_Certificadomilitar: String;
    fTp_Categoriamilitar: String;
    fDs_Dispensamilitar: String;
    fNr_Nit: String;
    fDs_Siglaufctps: String;
    fIn_Trabinformal: String;
    fDt_Casamento: String;
    fTp_Regcasamento: String;
    fNr_Pis: String;
    fDt_Emissaopis: String;
    fDs_Siglaufpis: String;
    fDt_Emissaoctps: String;
    fNr_Inscprodrural: String;
    fDs_Ufprodrural: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Tp_Escolaridade : String read fTp_Escolaridade write fTp_Escolaridade;
    property Qt_Filhos : String read fQt_Filhos write fQt_Filhos;
    property Qt_Dependentes : String read fQt_Dependentes write fQt_Dependentes;
    property Qt_Resantmeses : String read fQt_Resantmeses write fQt_Resantmeses;
    property Qt_Traantmeses : String read fQt_Traantmeses write fQt_Traantmeses;
    property Ds_Traantlocal : String read fDs_Traantlocal write fDs_Traantlocal;
    property Dt_Residedesde : String read fDt_Residedesde write fDt_Residedesde;
    property Tp_Casa : String read fTp_Casa write fTp_Casa;
    property Tp_Carro : String read fTp_Carro write fTp_Carro;
    property Nr_Escore : String read fNr_Escore write fNr_Escore;
    property Nr_Risco : String read fNr_Risco write fNr_Risco;
    property Dt_Atualizspc : String read fDt_Atualizspc write fDt_Atualizspc;
    property In_Ambulante : String read fIn_Ambulante write fIn_Ambulante;
    property Nr_Ambulante : String read fNr_Ambulante write fNr_Ambulante;
    property Tp_Rg : String read fTp_Rg write fTp_Rg;
    property Dt_Expedicaorg : String read fDt_Expedicaorg write fDt_Expedicaorg;
    property Ds_Passaporte : String read fDs_Passaporte write fDs_Passaporte;
    property Cd_Paispassaporte : String read fCd_Paispassaporte write fCd_Paispassaporte;
    property Nr_Cnh : String read fNr_Cnh write fNr_Cnh;
    property Dt_Validadecnh : String read fDt_Validadecnh write fDt_Validadecnh;
    property Dt_Primeirahab : String read fDt_Primeirahab write fDt_Primeirahab;
    property Ds_Orgaocnh : String read fDs_Orgaocnh write fDs_Orgaocnh;
    property Tp_Categoriacnh : String read fTp_Categoriacnh write fTp_Categoriacnh;
    property Nr_Tituloeleitor : String read fNr_Tituloeleitor write fNr_Tituloeleitor;
    property Nr_Zonaeleitor : String read fNr_Zonaeleitor write fNr_Zonaeleitor;
    property Nr_Secaoeleitor : String read fNr_Secaoeleitor write fNr_Secaoeleitor;
    property Tp_Certificadomilitar : String read fTp_Certificadomilitar write fTp_Certificadomilitar;
    property Tp_Categoriamilitar : String read fTp_Categoriamilitar write fTp_Categoriamilitar;
    property Ds_Dispensamilitar : String read fDs_Dispensamilitar write fDs_Dispensamilitar;
    property Nr_Nit : String read fNr_Nit write fNr_Nit;
    property Ds_Siglaufctps : String read fDs_Siglaufctps write fDs_Siglaufctps;
    property In_Trabinformal : String read fIn_Trabinformal write fIn_Trabinformal;
    property Dt_Casamento : String read fDt_Casamento write fDt_Casamento;
    property Tp_Regcasamento : String read fTp_Regcasamento write fTp_Regcasamento;
    property Nr_Pis : String read fNr_Pis write fNr_Pis;
    property Dt_Emissaopis : String read fDt_Emissaopis write fDt_Emissaopis;
    property Ds_Siglaufpis : String read fDs_Siglaufpis write fDs_Siglaufpis;
    property Dt_Emissaoctps : String read fDt_Emissaoctps write fDt_Emissaoctps;
    property Nr_Inscprodrural : String read fNr_Inscprodrural write fNr_Inscprodrural;
    property Ds_Ufprodrural : String read fDs_Ufprodrural write fDs_Ufprodrural;
  end;

  TPes_Pfadics = class(TList)
  public
    function Add: TPes_Pfadic; overload;
  end;

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

//--

function TPes_Pfadic.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PES_PFADIC';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Pessoa', 'CD_PESSOA', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Tp_Escolaridade', 'TP_ESCOLARIDADE', tfNul);
    Add('Qt_Filhos', 'QT_FILHOS', tfNul);
    Add('Qt_Dependentes', 'QT_DEPENDENTES', tfNul);
    Add('Qt_Resantmeses', 'QT_RESANTMESES', tfNul);
    Add('Qt_Traantmeses', 'QT_TRAANTMESES', tfNul);
    Add('Ds_Traantlocal', 'DS_TRAANTLOCAL', tfNul);
    Add('Dt_Residedesde', 'DT_RESIDEDESDE', tfNul);
    Add('Tp_Casa', 'TP_CASA', tfNul);
    Add('Tp_Carro', 'TP_CARRO', tfNul);
    Add('Nr_Escore', 'NR_ESCORE', tfNul);
    Add('Nr_Risco', 'NR_RISCO', tfNul);
    Add('Dt_Atualizspc', 'DT_ATUALIZSPC', tfNul);
    Add('In_Ambulante', 'IN_AMBULANTE', tfNul);
    Add('Nr_Ambulante', 'NR_AMBULANTE', tfNul);
    Add('Tp_Rg', 'TP_RG', tfNul);
    Add('Dt_Expedicaorg', 'DT_EXPEDICAORG', tfNul);
    Add('Ds_Passaporte', 'DS_PASSAPORTE', tfNul);
    Add('Cd_Paispassaporte', 'CD_PAISPASSAPORTE', tfNul);
    Add('Nr_Cnh', 'NR_CNH', tfNul);
    Add('Dt_Validadecnh', 'DT_VALIDADECNH', tfNul);
    Add('Dt_Primeirahab', 'DT_PRIMEIRAHAB', tfNul);
    Add('Ds_Orgaocnh', 'DS_ORGAOCNH', tfNul);
    Add('Tp_Categoriacnh', 'TP_CATEGORIACNH', tfNul);
    Add('Nr_Tituloeleitor', 'NR_TITULOELEITOR', tfNul);
    Add('Nr_Zonaeleitor', 'NR_ZONAELEITOR', tfNul);
    Add('Nr_Secaoeleitor', 'NR_SECAOELEITOR', tfNul);
    Add('Tp_Certificadomilitar', 'TP_CERTIFICADOMILITAR', tfNul);
    Add('Tp_Categoriamilitar', 'TP_CATEGORIAMILITAR', tfNul);
    Add('Ds_Dispensamilitar', 'DS_DISPENSAMILITAR', tfNul);
    Add('Nr_Nit', 'NR_NIT', tfNul);
    Add('Ds_Siglaufctps', 'DS_SIGLAUFCTPS', tfNul);
    Add('In_Trabinformal', 'IN_TRABINFORMAL', tfNul);
    Add('Dt_Casamento', 'DT_CASAMENTO', tfNul);
    Add('Tp_Regcasamento', 'TP_REGCASAMENTO', tfNul);
    Add('Nr_Pis', 'NR_PIS', tfNul);
    Add('Dt_Emissaopis', 'DT_EMISSAOPIS', tfNul);
    Add('Ds_Siglaufpis', 'DS_SIGLAUFPIS', tfNul);
    Add('Dt_Emissaoctps', 'DT_EMISSAOCTPS', tfNul);
    Add('Nr_Inscprodrural', 'NR_INSCPRODRURAL', tfNul);
    Add('Ds_Ufprodrural', 'DS_UFPRODRURAL', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPes_Pfadics }

function TPes_Pfadics.Add: TPes_Pfadic;
begin
  Result := TPes_Pfadic.Create(nil);
  Self.Add(Result);
end;

end.