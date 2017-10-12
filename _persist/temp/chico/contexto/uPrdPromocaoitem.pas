unit uPrdPromocaoitem;

interface

uses
  Classes, SysUtils,
  mMapping;

type
  TPrd_Promocaoitem = class(TmMapping)
  private
    fCd_Empresa: String;
    fCd_Promocao: String;
    fCd_Produto: String;
    fU_Version: String;
    fVl_Anterior: String;
    fVl_Promocao: String;
    fCd_Operador: String;
    fDt_Cadastro: String;
    fQt_Promovida: String;
    fQt_Vendida: String;
    fTp_Situacao: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMapping() : PmMapping; override;
  published
    property Cd_Empresa : String read fCd_Empresa write fCd_Empresa;
    property Cd_Promocao : String read fCd_Promocao write fCd_Promocao;
    property Cd_Produto : String read fCd_Produto write fCd_Produto;
    property U_Version : String read fU_Version write fU_Version;
    property Vl_Anterior : String read fVl_Anterior write fVl_Anterior;
    property Vl_Promocao : String read fVl_Promocao write fVl_Promocao;
    property Cd_Operador : String read fCd_Operador write fCd_Operador;
    property Dt_Cadastro : String read fDt_Cadastro write fDt_Cadastro;
    property Qt_Promovida : String read fQt_Promovida write fQt_Promovida;
    property Qt_Vendida : String read fQt_Vendida write fQt_Vendida;
    property Tp_Situacao : String read fTp_Situacao write fTp_Situacao;
  end;

  TPrd_Promocaoitems = class(TList)
  public
    function Add: TPrd_Promocaoitem; overload;
  end;

implementation

{ TPrd_Promocaoitem }

constructor TPrd_Promocaoitem.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TPrd_Promocaoitem.Destroy;
begin

  inherited;
end;

//--

function TPrd_Promocaoitem.GetMapping: PmMapping;
begin
  Result := New(PmMapping);

  Result.Tabela := New(PmTabela);
  with Result.Tabela^ do begin
    Nome := 'PRD_PROMOCAOITEM';
  end;

  Result.Campos := TmCampos.Create;
  with Result.Campos do begin
    Add('Cd_Empresa', 'CD_EMPRESA', tfKey);
    Add('Cd_Promocao', 'CD_PROMOCAO', tfKey);
    Add('Cd_Produto', 'CD_PRODUTO', tfKey);
    Add('U_Version', 'U_VERSION', tfNul);
    Add('Vl_Anterior', 'VL_ANTERIOR', tfNul);
    Add('Vl_Promocao', 'VL_PROMOCAO', tfNul);
    Add('Cd_Operador', 'CD_OPERADOR', tfReq);
    Add('Dt_Cadastro', 'DT_CADASTRO', tfReq);
    Add('Qt_Promovida', 'QT_PROMOVIDA', tfNul);
    Add('Qt_Vendida', 'QT_VENDIDA', tfNul);
    Add('Tp_Situacao', 'TP_SITUACAO', tfNul);
  end;

  Result.Relacoes := TmRelacoes.Create;
  with Result.Relacoes do begin
  end;
end;

//--

{ TPrd_Promocaoitems }

function TPrd_Promocaoitems.Add: TPrd_Promocaoitem;
begin
  Result := TPrd_Promocaoitem.Create(nil);
  Self.Add(Result);
end;

end.