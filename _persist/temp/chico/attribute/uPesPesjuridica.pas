unit uPesPesjuridica;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_PESJURIDICA')]
  TPes_Pesjuridica = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('NM_FANTASIA', tfNul)]
    property Nm_Fantasia : String read fNm_Fantasia write fNm_Fantasia;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('CD_ATIVIDADE', tfNul)]
    property Cd_Atividade : String read fCd_Atividade write fCd_Atividade;
    [Campo('QT_FUNCIONARIO', tfNul)]
    property Qt_Funcionario : String read fQt_Funcionario write fQt_Funcionario;
    [Campo('NR_CNPJ', tfNul)]
    property Nr_Cnpj : String read fNr_Cnpj write fNr_Cnpj;
    [Campo('VL_FATMENSAL', tfNul)]
    property Vl_Fatmensal : String read fVl_Fatmensal write fVl_Fatmensal;
    [Campo('NR_INSCESTL', tfNul)]
    property Nr_Inscestl : String read fNr_Inscestl write fNr_Inscestl;
    [Campo('DT_FUNDACAO', tfNul)]
    property Dt_Fundacao : String read fDt_Fundacao write fDt_Fundacao;
    [Campo('TP_REGIMETRIB', tfNul)]
    property Tp_Regimetrib : String read fTp_Regimetrib write fTp_Regimetrib;
    [Campo('VL_CAPITALSOCIAL', tfNul)]
    property Vl_Capitalsocial : String read fVl_Capitalsocial write fVl_Capitalsocial;
    [Campo('DS_UF', tfNul)]
    property Ds_Uf : String read fDs_Uf write fDs_Uf;
  end;

  TPes_Pesjuridicas = class(TList<Pes_Pesjuridica>);

implementation

{ TPes_Pesjuridica }

constructor TPes_Pesjuridica.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pesjuridica.Destroy;
begin

  inherited;
end;

end.