unit uPesPfadic;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Pfadic = class;
  TPes_PfadicClass = class of TPes_Pfadic;

  TPes_PfadicList = class;
  TPes_PfadicListClass = class of TPes_PfadicList;

  TPes_Pfadic = class(TmCollectionItem)
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
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property U_Version : String read fU_Version write SetU_Version;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property Tp_Escolaridade : String read fTp_Escolaridade write SetTp_Escolaridade;
    property Qt_Filhos : String read fQt_Filhos write SetQt_Filhos;
    property Qt_Dependentes : String read fQt_Dependentes write SetQt_Dependentes;
    property Qt_Resantmeses : String read fQt_Resantmeses write SetQt_Resantmeses;
    property Qt_Traantmeses : String read fQt_Traantmeses write SetQt_Traantmeses;
    property Ds_Traantlocal : String read fDs_Traantlocal write SetDs_Traantlocal;
    property Dt_Residedesde : String read fDt_Residedesde write SetDt_Residedesde;
    property Tp_Casa : String read fTp_Casa write SetTp_Casa;
    property Tp_Carro : String read fTp_Carro write SetTp_Carro;
    property Nr_Escore : String read fNr_Escore write SetNr_Escore;
    property Nr_Risco : String read fNr_Risco write SetNr_Risco;
    property Dt_Atualizspc : String read fDt_Atualizspc write SetDt_Atualizspc;
    property In_Ambulante : String read fIn_Ambulante write SetIn_Ambulante;
    property Nr_Ambulante : String read fNr_Ambulante write SetNr_Ambulante;
    property Tp_Rg : String read fTp_Rg write SetTp_Rg;
    property Dt_Expedicaorg : String read fDt_Expedicaorg write SetDt_Expedicaorg;
    property Ds_Passaporte : String read fDs_Passaporte write SetDs_Passaporte;
    property Cd_Paispassaporte : String read fCd_Paispassaporte write SetCd_Paispassaporte;
    property Nr_Cnh : String read fNr_Cnh write SetNr_Cnh;
    property Dt_Validadecnh : String read fDt_Validadecnh write SetDt_Validadecnh;
    property Dt_Primeirahab : String read fDt_Primeirahab write SetDt_Primeirahab;
    property Ds_Orgaocnh : String read fDs_Orgaocnh write SetDs_Orgaocnh;
    property Tp_Categoriacnh : String read fTp_Categoriacnh write SetTp_Categoriacnh;
    property Nr_Tituloeleitor : String read fNr_Tituloeleitor write SetNr_Tituloeleitor;
    property Nr_Zonaeleitor : String read fNr_Zonaeleitor write SetNr_Zonaeleitor;
    property Nr_Secaoeleitor : String read fNr_Secaoeleitor write SetNr_Secaoeleitor;
    property Tp_Certificadomilitar : String read fTp_Certificadomilitar write SetTp_Certificadomilitar;
    property Tp_Categoriamilitar : String read fTp_Categoriamilitar write SetTp_Categoriamilitar;
    property Ds_Dispensamilitar : String read fDs_Dispensamilitar write SetDs_Dispensamilitar;
    property Nr_Nit : String read fNr_Nit write SetNr_Nit;
    property Ds_Siglaufctps : String read fDs_Siglaufctps write SetDs_Siglaufctps;
    property In_Trabinformal : String read fIn_Trabinformal write SetIn_Trabinformal;
    property Dt_Casamento : String read fDt_Casamento write SetDt_Casamento;
    property Tp_Regcasamento : String read fTp_Regcasamento write SetTp_Regcasamento;
    property Nr_Pis : String read fNr_Pis write SetNr_Pis;
    property Dt_Emissaopis : String read fDt_Emissaopis write SetDt_Emissaopis;
    property Ds_Siglaufpis : String read fDs_Siglaufpis write SetDs_Siglaufpis;
    property Dt_Emissaoctps : String read fDt_Emissaoctps write SetDt_Emissaoctps;
    property Nr_Inscprodrural : String read fNr_Inscprodrural write SetNr_Inscprodrural;
    property Ds_Ufprodrural : String read fDs_Ufprodrural write SetDs_Ufprodrural;
  end;

  TPes_PfadicList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Pfadic;
    procedure SetItem(Index: Integer; Value: TPes_Pfadic);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Pfadic;
    property Items[Index: Integer]: TPes_Pfadic read GetItem write SetItem; default;
  end;

implementation

{ TPes_Pfadic }

constructor TPes_Pfadic.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Pfadic.Destroy;
begin

  inherited;
end;

{ TPes_PfadicList }

constructor TPes_PfadicList.Create(AOwner: TPersistentCollection);
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