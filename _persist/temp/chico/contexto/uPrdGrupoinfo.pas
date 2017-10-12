unit uPrdGrupoinfo;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Grupoinfo = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Seqgrupo: String;
    fU_Version: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fPr_Markup: String;
    fPr_Comissao: String;
    fIn_Prodpropria: String;
    fIn_Inativo: String;
    fIn_Prodacabado: String;
    fIn_Matprima: String;
    fIn_Matconsumo: String;
    fIn_Patrimonio: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Seqgrupo : String read fCd_Seqgrupo write fCd_Seqgrupo;
    property U_Version : String read fU_Version write fU_Version;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Pr_Markup : String read fPr_Markup write fPr_Markup;
    property Pr_Comissao : String read fPr_Comissao write fPr_Comissao;
    property In_Prodpropria : String read fIn_Prodpropria write fIn_Prodpropria;
    property In_Inativo : String read fIn_Inativo write fIn_Inativo;
    property In_Prodacabado : String read fIn_Prodacabado write fIn_Prodacabado;
    property In_Matprima : String read fIn_Matprima write fIn_Matprima;
    property In_Matconsumo : String read fIn_Matconsumo write fIn_Matconsumo;
    property In_Patrimonio : String read fIn_Patrimonio write fIn_Patrimonio;
  end;

  TPrd_Grupoinfos = class(TList)
  public
    function Add: TPrd_Grupoinfo; overload;
  end;

implementation

{ TPrd_Grupoinfo }

constructor TPrd_Grupoinfo.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Grupoinfo.Destroy;
begin

  inherited;
end;

//--

function TPrd_Grupoinfo.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_GRUPOINFO';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Seqgrupo', 'CD_SEQGRUPO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Pr_Markup', 'PR_MARKUP', tfNul);
    Add('Pr_Comissao', 'PR_COMISSAO', tfNul);
    Add('In_Prodpropria', 'IN_PRODPROPRIA', tfNul);
    Add('In_Inativo', 'IN_INATIVO', tfNul);
    Add('In_Prodacabado', 'IN_PRODACABADO', tfNul);
    Add('In_Matprima', 'IN_MATPRIMA', tfNul);
    Add('In_Matconsumo', 'IN_MATCONSUMO', tfNul);
    Add('In_Patrimonio', 'IN_PATRIMONIO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Grupoinfos }

function TPrd_Grupoinfos.Add: TPrd_Grupoinfo;
begin
  Result := TPrd_Grupoinfo.Create(nil);
  Self.Add(Result);
end;

end.