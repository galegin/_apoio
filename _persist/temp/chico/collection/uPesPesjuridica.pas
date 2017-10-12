unit uPesPesjuridica;

interface

uses
  Classes, SysUtils,
  mCollection, mCollectionItem;

type
  TPes_Pesjuridica = class;
  TPes_PesjuridicaClass = class of TPes_Pesjuridica;

  TPes_PesjuridicaList = class;
  TPes_PesjuridicaListClass = class of TPes_PesjuridicaList;

  TPes_Pesjuridica = class(TmCollectionItem)
  private
    fCd_Pessoa: String;
    fU_Version: String;
    fNm_Fantasia: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fIn_Inativo: String;
    fCd_Atividade: String;
    fQt_Funcionario: String;
    fNr_Cnpj: String;
    fVl_Fatmensal: String;
    fNr_Inscestl: String;
    fDt_Fundacao: String;
    fTp_Regimetrib: String;
    fVl_Capitalsocial: String;
    fDs_Uf: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Cd_Pessoa : String read fCd_Pessoa write SetCd_Pessoa;
    property U_Version : String read fU_Version write SetU_Version;
    property Nm_Fantasia : String read fNm_Fantasia write SetNm_Fantasia;
    property Cd_Operador : String read fCd_Operador write SetCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write SetDt_Cadastro;
    property In_Inativo : String read fIn_Inativo write SetIn_Inativo;
    property Cd_Atividade : String read fCd_Atividade write SetCd_Atividade;
    property Qt_Funcionario : String read fQt_Funcionario write SetQt_Funcionario;
    property Nr_Cnpj : String read fNr_Cnpj write SetNr_Cnpj;
    property Vl_Fatmensal : String read fVl_Fatmensal write SetVl_Fatmensal;
    property Nr_Inscestl : String read fNr_Inscestl write SetNr_Inscestl;
    property Dt_Fundacao : String read fDt_Fundacao write SetDt_Fundacao;
    property Tp_Regimetrib : String read fTp_Regimetrib write SetTp_Regimetrib;
    property Vl_Capitalsocial : String read fVl_Capitalsocial write SetVl_Capitalsocial;
    property Ds_Uf : String read fDs_Uf write SetDs_Uf;
  end;

  TPes_PesjuridicaList = class(TmCollection)
  private
    function GetItem(Index: Integer): TPes_Pesjuridica;
    procedure SetItem(Index: Integer; Value: TPes_Pesjuridica);
  public
    constructor Create(AOwner: TPersistentCollection);
    function Add: TPes_Pesjuridica;
    property Items[Index: Integer]: TPes_Pesjuridica read GetItem write SetItem; default;
  end;

implementation

{ TPes_Pesjuridica }

constructor TPes_Pesjuridica.Create(ACollection: TCollection);
begin
  inherited;

end;

destructor TPes_Pesjuridica.Destroy;
begin

  inherited;
end;

{ TPes_PesjuridicaList }

constructor TPes_PesjuridicaList.Create(AOwner: TPersistentCollection);
begin
  inherited Create(TPes_Pesjuridica);
end;

function TPes_PesjuridicaList.Add: TPes_Pesjuridica;
begin
  Result := TPes_Pesjuridica(inherited Add);
  Result.create;
end;

function TPes_PesjuridicaList.GetItem(Index: Integer): TPes_Pesjuridica;
begin
  Result := TPes_Pesjuridica(inherited GetItem(Index));
end;

procedure TPes_PesjuridicaList.SetItem(Index: Integer; Value: TPes_Pesjuridica);
begin
  inherited SetItem(Index, Value);
end;

end.