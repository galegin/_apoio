unit uclsTransacaoServico;

interface

uses
  Classes, SysUtils, StrUtils, Math,
  uEmpresa, uPessoa, uProduto, uOperacao,
  uTransacao, uTransitem, uTransimposto;

type
  TcTransacaoServico = class(TComponent)
  private
    fEmpresa : TEmpresa;
    fPessoa : TPessoa;
    fProduto : TProduto;
    fOperacao : TOperacao;
    fTransacao : TTransacao;
    fTransitem : TTransitem;
    function GetVl_Total: Real;
  protected
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function Listar() : TTransacaoList;

    procedure LimparCapa();

    procedure BuscarCapa(ACd_Dnatrans : String);

    function NumerarCapa() : Integer;
    function NumerarFiscal(ACd_Serie : String) : Integer;

    procedure Salvar(
      ACd_Equip: String;
      ADt_Transacao: TDateTime;
      ANr_Cpfcnpj: String;
      ACd_Operacao: String;
      ACd_Dnapagto: String = '';
      ADt_Canc: TDateTime = 0);

    procedure Excluir(ACd_Dnatrans: String);

    procedure AdicionarItem(
      ACd_Barraprd: String;
      AQt_Item: Real = 1;
      AVl_Variacao: Real = 0;
      AVl_VariacaoCapa: Real = 0);

    procedure RecalcularImpostoItem(
      AObj_Item : TTransitem);

    function BuscarItem(ANr_Item: Integer) : TTransitem;
    procedure ExcluirItem(ANr_Item: Integer);

    procedure GravarVariacaoCapa(AVl_Variacao: Real);
    procedure ExcluirVariacaoCapa();

    procedure GravarVariacaoItem(ANr_Item: Integer; AVl_Variacao: Real);
    procedure ExcluirVariacaoItem(ANr_Item: Integer);

    procedure LimparVencto();
    procedure GerarVencto(
      ADt_Parcela: TDateTime;
      AVl_Parcela: Real);

    procedure LimparPagto();
    procedure GerarPagto(
      ATp_Pagto : Integer;
      AVl_Pagto : Real);

    procedure EmitirDFe();  

  published
    property Transacao : TTransacao read fTransacao write fTransacao;
    property Vl_Total : Real read GetVl_Total;
  end;

  function Instance : TcTransacaoServico;
  procedure Destroy;

implementation

uses
  uclsEmpresaServico,
  uclsPessoaServico,
  uclsProdutoServico,
  uclsOperacaoServico,
  uclsImpostoServico,
  uclsDFeServico,
  mCollection, mCollectionItem, mSequence, mFloat,
  uTransfiscal, uTransvencto, uTranspagto, uTipoProcessamento;

var
  _instance : TcTransacaoServico;

  function Instance : TcTransacaoServico;
  begin
    if not Assigned(_instance) then
      _instance := TcTransacaoServico.Create(nil);
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

constructor TcTransacaoServico.Create(AOwner : TComponent);
begin
  inherited;

  fEmpresa := TEmpresa.Create(nil);
  fTransacao := TTransacao.Create(nil);
end;

destructor TcTransacaoServico.Destroy;
begin
  FreeAndNil(fTransacao);
  FreeAndNil(fEmpresa);

  inherited;
end;

function TcTransacaoServico.Listar;
begin
  Result := TTransacaoList(fTransacao.Listar(nil));
end;

procedure TcTransacaoServico.LimparCapa;
begin
  fTransacao.Limpar();
end;

procedure TcTransacaoServico.BuscarCapa;
begin
  fTransacao.Limpar();
  if ACd_Dnatrans <> '' then begin
    fTransacao.Cd_Dnatrans := ACd_Dnatrans;
    fTransacao.Consultar(nil);
  end;
end;

function TcTransacaoServico.NumerarCapa;
begin
  Result := mSequence.Instance.GetSequencia('TRANSACAO');
end;

function TcTransacaoServico.NumerarFiscal;
begin
  Result := mSequence.Instance.GetSequencia('TRANSACAO', 'NF', 0, 0, ACd_Serie);
end;

procedure TcTransacaoServico.Salvar;
const
  cDS_METHOD = 'TcTransacaoServico.Salvar()';
var
  vNr_Transacao, vNr_Docfiscal : Integer;
begin
  if ANr_Cpfcnpj = '' then
    raise Exception.Create('Pessoa deve ser informado / ' + cDS_METHOD);
  if ACd_Operacao = '' then
    raise Exception.Create('Operacao deve ser informado / ' + cDS_METHOD);

  fEmpresa := uclsEmpresaServico.Instance.Consultar();
  if not Assigned(fEmpresa) then
    raise Exception.Create('Empresa nao encontrada / ' + cDS_METHOD);

  fPessoa := uclsPessoaServico.Instance.Consultar(ANr_Cpfcnpj);
  if not Assigned(fPessoa) then
    raise Exception.Create('Pessoa ' + ANr_Cpfcnpj + ' nao encontrada / ' + cDS_METHOD);

  fOperacao := uclsOperacaoServico.Instance.Consultar(ACd_Operacao);
  if not Assigned(fOperacao) then
    raise Exception.Create('Operacao ' + ACd_Operacao + ' nao encontrada / ' + cDS_METHOD);

  vNr_Transacao := NumerarCapa();
  vNr_Docfiscal := NumerarFiscal(fOperacao.Cd_Serie);

  with fTransacao do begin
    Cd_Dnatrans :=
      ACd_Equip + '#' +
      FormatDateTime('yyyymmdd', ADt_Transacao) + '#' +
      IntToStr(vNr_Transacao);

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Cd_Equip := ACd_Equip;
    Dt_Transacao := ADt_Transacao;
    Nr_Transacao := vNr_Transacao;
    Nr_Cpfcnpj := ANr_Cpfcnpj;
    Cd_Operacao := fOperacao.Cd_Operacao;
    Cd_Dnapagto := ACd_Dnapagto;
    Dt_Canc := ADt_Canc;

    Obj_Empresa := fEmpresa;
    Obj_Operacao := fOperacao;
    Obj_Pessoa := fPessoa;

    with Obj_Fiscal do begin
      Cd_Dnatrans := fTransacao.Cd_Dnatrans;

      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;

      Tp_Docfiscal := fOperacao.Tp_Docfiscal;
      Nr_Docfiscal := vNr_Docfiscal;
      Tp_Modalidade := fOperacao.Tp_Modalidade;
      Tp_Operacao := fOperacao.Tp_Operacao;
      Cd_Serie := fOperacao.Cd_Serie;
      Tp_Ambiente := 0;
      Tp_Emissao := 0;
      Dh_Emissao := Now;
      Dh_EntradaSaida := Now;
      Dh_Recibo := 0;
      Nr_Recibo := '';
      Tp_Processamento := TipoProcessamentoToStr(tppGerada);
    end;

    Incluir();
  end;
end;

procedure TcTransacaoServico.Excluir;
begin
  with fTransacao do begin
    Limpar();
    if ACd_Dnatrans <> '' then begin
      Cd_Dnatrans := ACd_Dnatrans;
      Excluir();
    end;
  end;
end;

//--

procedure TcTransacaoServico.AdicionarItem;
const
  cDS_METHOD = 'TcTransacaoServico.AdicionarItem()';
begin
  if ACd_Barraprd = '' then
    raise Exception.Create('Produto deve ser informado / ' + cDS_METHOD);

  fProduto := uclsProdutoServico.Instance.Consultar(ACd_Barraprd);
  if not Assigned(fProduto) then
    raise Exception.Create('Produto ' + ACd_Barraprd + ' nao encontrado / ' + cDS_METHOD);

  fTransitem := fTransacao.List_Item.Add;
  fTransitem.Obj_Produto := fProduto;

  with fTransitem do begin
    Cd_Dnatrans := fTransacao.Cd_Dnatrans;
    Nr_Item := fTransacao.List_Item.Count;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Cd_Barraprd := fProduto.Cd_Barraprd;
    Cd_Produto := fProduto.Cd_Produto;
    Ds_Produto := fProduto.Ds_Produto;
    Cd_Especie := fProduto.Cd_Especie;
    Cd_Ncm := fProduto.Cd_Ncm;
    Cd_Cfop := fOperacao.Cd_Cfop;
    Qt_Item := AQt_Item;
    Vl_Custo := fProduto.Vl_Custo;
    Vl_Unitario := fProduto.Vl_Venda;
    Vl_Item := Vl_Unitario * Qt_Item;
    Vl_Variacao := AVl_Variacao;
    Vl_VariacaoCapa := AVl_VariacaoCapa;

    uclsImpostoServico.Instance.Gerar(
      fTransacao,
      fTransitem);

    Incluir();
  end;
end;

function TcTransacaoServico.BuscarItem;
var
  I : Integer;
begin
  Result := nil;

  with fTransacao do
    for I := 0 to List_Item.Count - 1 do
      with List_Item[I] do
        if Nr_Item = ANr_Item then begin
          Result := List_Item[I];
          Break;
        end;
end;

procedure TcTransacaoServico.ExcluirItem;
var
  I : Integer;
begin
  with fTransacao do
    for I := List_Item.Count - 1 downto 0 do
      with List_Item[I] do
        if Nr_Item = ANr_Item then begin
          Excluir();
          Limpar();
          Break;
        end;
end;

//--

procedure TcTransacaoServico.GravarVariacaoCapa;
var
  vVl_Resto, vPr_Proporcao : Real;
  vTransitemMaior : TTransitem;
  I : Integer;
begin
  vVl_Resto := AVl_Variacao;
  vTransitemMaior := nil;

  with fTransacao do begin
    for I := 0 to List_Item.Count - 1 do begin
      with List_Item[I] do begin
        vPr_Proporcao := Vl_Item / fTransacao.Vl_Item;
        Vl_VariacaoCapa := TmFloat.Rounded(AVl_Variacao * vPr_Proporcao, 2);
        vVl_Resto := vVl_Resto - Vl_VariacaoCapa;

        if not Assigned(vTransitemMaior) or (Vl_Item > vTransitemMaior.Vl_Item) then
          vTransitemMaior := List_Item[I];
      end;

      if Assigned(vTransitemMaior) or (vVl_Resto <> 0) then
        with vTransitemMaior do
          Vl_VariacaoCapa := Vl_VariacaoCapa + vVl_Resto;
    end;

    Alterar();
  end;
end;

procedure TcTransacaoServico.ExcluirVariacaoCapa;
var
  I : Integer;
begin
  with fTransacao do begin
    for I := 0 to List_Item.Count - 1 do
      with List_Item[I] do
        Vl_VariacaoCapa := 0;

    Alterar();
  end;
end;

//--

procedure TcTransacaoServico.GravarVariacaoItem;
var
  vTransitem : TTransitem;
begin
  vTransitem := BuscarItem(ANr_Item);
  if Assigned(vTransitem) then begin
    with vTransitem do begin
      Vl_Variacao := AVl_Variacao;
      RecalcularImpostoItem(vTransitem);
      Alterar();
    end;
  end;
end;

procedure TcTransacaoServico.ExcluirVariacaoItem;
var
  vTransitem : TTransitem;
begin
  vTransitem := BuscarItem(ANr_Item);
  if Assigned(vTransitem) then begin
    with vTransitem do begin
      Vl_Variacao := 0;
      RecalcularImpostoItem(vTransitem);
      Alterar();
    end;
  end;
end;

//--

procedure TcTransacaoServico.RecalcularImpostoItem;
var
  vVl_Imposto : Real;
  I : Integer;
begin
  with AObj_Item do
    for I := 0 to List_Imposto.Count - 1 do
      with List_Imposto[I] do begin
        Vl_Basecalculo := Vl_Totitem;

        vVl_Imposto := TmFloat.Rounded(Vl_Basecalculo * (Pr_Aliquota / 100) * (Pr_Basecalculo / 100), 2);

        Vl_Imposto := IfThen(Vl_Imposto > 0, vVl_Imposto, 0);
        Vl_Outro := IfThen(Vl_Outro > 0, vVl_Imposto, 0);
        Vl_Isento := IfThen(Vl_Isento > 0, vVl_Imposto, 0);
      end;
end;

//-- VENCTO - NFCe / NFe

procedure TcTransacaoServico.LimparVencto();
begin
  with fTransacao.List_Vencto do begin
    Excluir();
    Limpar();
  end;
end;

procedure TcTransacaoServico.GerarVencto;
const
  cDS_METHOD = 'TcTransacaoServico.GerarVencto()';
begin
  if ADt_Parcela = 0 then
    raise Exception.Create('Data deve ser informada / ' + cDS_METHOD);
  if AVl_Parcela = 0 then
    raise Exception.Create('Valor deve ser informado / ' + cDS_METHOD);

  with fTransacao.List_Vencto.Add do begin
    Cd_Dnatrans := fTransacao.Cd_Dnatrans;
    Nr_Parcela := fTransacao.List_Vencto.Count;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Dt_Parcela := ADt_Parcela;
    Vl_Parcela := AVl_Parcela;

    Incluir();
  end;
end;

//-- PAGTO - NFCe

procedure TcTransacaoServico.LimparPagto();
begin
  with fTransacao.List_Pagto do begin
    Excluir();
    Limpar();
  end;
end;

procedure TcTransacaoServico.GerarPagto;
const
  cDS_METHOD = 'TcTransacaoServico.GerarPagto()';
begin
  if ATp_Pagto = 0 then
    raise Exception.Create('Tipo deve ser informada / ' + cDS_METHOD);
  if AVl_Pagto = 0 then
    raise Exception.Create('Valor deve ser informado / ' + cDS_METHOD);

  with fTransacao.List_Pagto.Add do begin
    Cd_Dnatrans := fTransacao.Cd_Dnatrans;
    Nr_Pagto := fTransacao.List_Pagto.Count;

    U_Version := '';
    Cd_Operador := 1;
    Dt_Cadastro := Now;

    Tp_Pagto := ATp_Pagto;
    Vl_Pagto := AVl_Pagto;

    Incluir();
  end;
end;

//--

procedure TcTransacaoServico.EmitirDFe;
begin
  with fTransacao do
    if Obj_Operacao.Tp_Docfiscal in [55, 65] then
      if Cd_Dnatrans <> '' then
        uclsDFeServico.Instance.EmitirDFe(Transacao);
end;

//--

function TcTransacaoServico.GetVl_Total: Real;
begin
  Result := 0; 
  with fTransacao do
    if Cd_Dnatrans <> '' then
      Result := Vl_Total;
end;

initialization
  //Instance();

finalization
  Destroy();

end.
