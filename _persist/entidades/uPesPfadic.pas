unit uPesPfadic;

interface

uses
  Classes, SysUtils,
  cCollection, cCollectionItem;

type
  TPes_Pfadic = class;
  TPes_PfadicClass = class of TPes_Pfadic;

  TPes_PfadicList = class;
  TPes_PfadicListClass = class of TPes_PfadicList;

  TPes_Pfadic = class(TcCollectionItem)
  private
    fCd_Pessoa: Real;
    fU_Version: String;
    fCd_Operador: Real;
    fDt_Cadastro: TDateTime;
    fTp_Escolaridade: Real;
    fQt_Filhos: Real;
    fQt_Dependentes: Real;
    fQt_Resantmeses: Real;
    fQt_Traantmeses: Real;
    fDs_Traantlocal: String;
    fDt_Residedesde: TDateTime;
    fTp_Casa: Real;
    fTp_Carro: Real;
    fNr_Escore: Real;
    fNr_Risco: Real;
    fDt_Atualizspc: TDateTime;
    fIn_Ambulante: String;
    fNr_Ambulante: String;
    fTp_Rg: Real;
    fDt_Expedicaorg: TDateTime;
    fDs_Passaporte: String;
    fCd_Paispassaporte: Real;
    fNr_Cnh: String;
    fDt_Validadecnh: TDateTime;
    fDt_Primeirahab: TDateTime;
    fDs_Orgaocnh: String;
    fTp_Categoriacnh: String;
    fNr_Tituloeleitor: String;
    fNr_Zonaeleitor: String;
    fNr_Secaoeleitor: String;
    fTp_Certificadomilitar: Real;
    fTp_Categoriamilitar: Real;
    fDs_Dispensamilitar: String;
    fNr_Nit: String;
    fDs_Siglaufctps: String;
    fIn_Trabinformal: String;
    fDt_Casamento: TDateTime;
    fTp_Regcasamento: Real;
    fNr_Pis: String;
    fDt_Emissaopis: TDateTime;
    fDs_Siglaufpis: String;
    fDt_Emissaoctps: TDateTime;
    fNr_Inscprodrural: String;
    fDs_Ufprodrural: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Cd_Pessoa : Real read fCd_Pessoa write fCd_Pessoa;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : Real read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : TDateTime read fDt_Cadastro write fDt_Cadastro;
    property Tp_Escolaridade : Real read fTp_Escolaridade write fTp_Escolaridade;
    property Qt_Filhos : Real read fQt_Filhos write fQt_Filhos;
    property Qt_Dependentes : Real read fQt_Dependentes write fQt_Dependentes;
    property Qt_Resantmeses : Real read fQt_Resantmeses write fQt_Resantmeses;
    property Qt_Traantmeses : Real read fQt_Traantmeses write fQt_Traantmeses;
    property Ds_Traantlocal : String read fDs_Traantlocal write fDs_Traantlocal;
    property Dt_Residedesde : TDateTime read fDt_Residedesde write fDt_Residedesde;
    property Tp_Casa : Real read fTp_Casa write fTp_Casa;
    property Tp_Carro : Real read fTp_Carro write fTp_Carro;
    property Nr_Escore : Real read fNr_Escore write fNr_Escore;
    property Nr_Risco : Real read fNr_Risco write fNr_Risco;
    property Dt_Atualizspc : TDateTime read fDt_Atualizspc write fDt_Atualizspc;
    property In_Ambulante : String read fIn_Ambulante write fIn_Ambulante;
    property Nr_Ambulante : String read fNr_Ambulante write fNr_Ambulante;
    property Tp_Rg : Real read fTp_Rg write fTp_Rg;
    property Dt_Expedicaorg : TDateTime read fDt_Expedicaorg write fDt_Expedicaorg;
    property Ds_Passaporte : String read fDs_Passaporte write fDs_Passaporte;
    property Cd_Paispassaporte : Real read fCd_Paispassaporte write fCd_Paispassaporte;
    property Nr_Cnh : String read fNr_Cnh write fNr_Cnh;
    property Dt_Validadecnh : TDateTime read fDt_Validadecnh write fDt_Validadecnh;
    property Dt_Primeirahab : TDateTime read fDt_Primeirahab write fDt_Primeirahab;
    property Ds_Orgaocnh : String read fDs_Orgaocnh write fDs_Orgaocnh;
    property Tp_Categoriacnh : String read fTp_Categoriacnh write fTp_Categoriacnh;
    property Nr_Tituloeleitor : String read fNr_Tituloeleitor write fNr_Tituloeleitor;
    property Nr_Zonaeleitor : String read fNr_Zonaeleitor write fNr_Zonaeleitor;
    property Nr_Secaoeleitor : String read fNr_Secaoeleitor write fNr_Secaoeleitor;
    property Tp_Certificadomilitar : Real read fTp_Certificadomilitar write fTp_Certificadomilitar;
    property Tp_Categoriamilitar : Real read fTp_Categoriamilitar write fTp_Categoriamilitar;
    property Ds_Dispensamilitar : String read fDs_Dispensamilitar write fDs_Dispensamilitar;
    property Nr_Nit : String read fNr_Nit write fNr_Nit;
    property Ds_Siglaufctps : String read fDs_Siglaufctps write fDs_Siglaufctps;
    property In_Trabinformal : String read fIn_Trabinformal write fIn_Trabinformal;
    property Dt_Casamento : TDateTime read fDt_Casamento write fDt_Casamento;
    property Tp_Regcasamento : Real read fTp_Regcasamento write fTp_Regcasamento;
    property Nr_Pis : String read fNr_Pis write fNr_Pis;
    property Dt_Emissaopis : TDateTime read fDt_Emissaopis write fDt_Emissaopis;
    property Ds_Siglaufpis : String read fDs_Siglaufpis write fDs_Siglaufpis;
    property Dt_Emissaoctps : TDateTime read fDt_Emissaoctps write fDt_Emissaoctps;
    property Nr_Inscprodrural : String read fNr_Inscprodrural write fNr_Inscprodrural;
    property Ds_Ufprodrural : String read fDs_Ufprodrural write fDs_Ufprodrural;
  end;

  TPes_PfadicList = class(TcCollection)
  private
    function GetItem(Index: Integer): TPes_Pfadic;
    procedure SetItem(Index: Integer; Value: TPes_Pfadic);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TPes_Pfadic;
    property Items[Index: Integer]: TPes_Pfadic read GetItem write SetItem; default;
  end;
  
implementation

{ TPes_Pfadic }

constructor TPes_Pfadic.Create;
begin

end;

destructor TPes_Pfadic.Destroy;
begin

  inherited;
end;

{ TPes_PfadicList }

constructor TPes_PfadicList.Create(AOwner: TPersistent);
begin
  inherited Create(TPes_Pfadic);
end;

function TPes_PfadicList.Add: TPes_Pfadic;
begin
  Result := TPes_Pfadic(inherited Add);
  Result.create;
end;

function TPes_PfadicList.GetItem(Index: Integer): TPes_Pfadic;
begin
  Result := TPes_Pfadic(inherited GetItem(Index));
end;

procedure TPes_PfadicList.SetItem(Index: Integer; Value: TPes_Pfadic);
begin
  inherited SetItem(Index, Value);
end;

end.