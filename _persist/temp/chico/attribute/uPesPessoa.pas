unit uPesPessoa;

interface

uses
  Classes, SysUtils,
  System.Generics.Collections,
  mMapping;

type
  [Tabela('PES_PESSOA')]
  TPes_Pessoa = class(TmMapping)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    [Campo('CD_PESSOA', tfKey)]
    property Cd_Pessoa : String read fCd_Pessoa write fCd_Pessoa;
    [Campo('U_VERSION', tfNul)]
    property U_Version : String read fU_Version write fU_Version;
    [Campo('TP_PESSOA', tfNul)]
    property Tp_Pessoa : String read fTp_Pessoa write fTp_Pessoa;
    [Campo('CD_EMPRESACAD', tfReq)]
    property Cd_Empresacad : String read fCd_Empresacad write fCd_Empresacad;
    [Campo('CD_OPERADORCAD', tfReq)]
    property Cd_Operadorcad : String read fCd_Operadorcad write fCd_Operadorcad;
    [Campo('CD_OPERADOR', tfReq)]
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    [Campo('DT_CADASTRO', tfReq)]
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    [Campo('DT_INCLUSAO', tfReq)]
    property Dt_Inclusao : String read fDt_Inclusao write fDt_Inclusao;
    [Campo('NM_PESSOA', tfReq)]
    property Nm_Pessoa : String read fNm_Pessoa write fNm_Pessoa;
    [Campo('NR_CPFCNPJ', tfNul)]
    property Nr_Cpfcnpj : String read fNr_Cpfcnpj write fNr_Cpfcnpj;
    [Campo('IN_CONTRIBUINTE', tfNul)]
    property In_Contribuinte : String read fIn_Contribuinte write fIn_Contribuinte;
    [Campo('IN_INATIVO', tfNul)]
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    [Campo('IN_PRIVADO', tfNul)]
    property In_Privado : String read fIn_Privado write fIn_Privado;
    [Campo('CD_COLIGADOR', tfNul)]
    property Cd_Coligador : String read fCd_Coligador write fCd_Coligador;
    [Campo('NR_SEQEMAIL', tfNul)]
    property Nr_Seqemail : String read fNr_Seqemail write fNr_Seqemail;
    [Campo('NR_SEQEND', tfNul)]
    property Nr_Seqend : String read fNr_Seqend write fNr_Seqend;
    [Campo('NR_SEQFONE', tfNul)]
    property Nr_Seqfone : String read fNr_Seqfone write fNr_Seqfone;
    [Campo('NR_ENDRES', tfNul)]
    property Nr_Endres : String read fNr_Endres write fNr_Endres;
    [Campo('NR_ENDCOB', tfNul)]
    property Nr_Endcob : String read fNr_Endcob write fNr_Endcob;
    [Campo('NR_ENDCOM', tfNul)]
    property Nr_Endcom : String read fNr_Endcom write fNr_Endcom;
    [Campo('NR_ENDENT', tfNul)]
    property Nr_Endent : String read fNr_Endent write fNr_Endent;
    [Campo('NR_ENDCOR', tfNul)]
    property Nr_Endcor : String read fNr_Endcor write fNr_Endcor;
    [Campo('DS_HOMEPAGE', tfNul)]
    property Ds_Homepage : String read fDs_Homepage write fDs_Homepage;
  end;

  TPes_Pessoas = class(TList<Pes_Pessoa>);

implementation

{ TPes_Pessoa }

constructor TPes_Pessoa.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPes_Pessoa.Destroy;
begin

  inherited;
end;

end.