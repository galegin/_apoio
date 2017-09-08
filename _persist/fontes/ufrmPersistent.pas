unit ufrmPersistent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TF_Persistent = class(TForm)
    BtnTestar: TButton;
    BtnGerar: TButton;
    MemoFiltro: TMemo;
    procedure BtnTestarClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
  private
  public
  end;

var
  F_Persistent: TF_Persistent;

implementation

{$R *.dfm}

uses
  uclsPersistent, mContexto, mMapping,
  uPessoa, uProduto, uTransacao, uTransitem;

procedure TF_Persistent.BtnTestarClick(Sender: TObject);
var
  vContexto : TmContexto;
  vPessoas : TPessoas;
  vPessoa : TPessoa;
  vTransacao : TTransacao;
  I : Integer;
begin
  vPessoas := TPessoas.Create;

  for I := 1 to 10 do
    with vPessoas.Add do begin
      Nr_Cpfcnpj := IntToStr(I);
      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;
      Nr_Rgie := '123';
      Cd_Pessoa := I * 10;
      Nm_Pessoa := 'Pessoa ' + IntToStr(I);
      Nm_Fantasia := 'Pessoa ' + IntToStr(I);
      Cd_Cep := 87200000;
      Nm_Logradouro := 'Rua';
      Nr_Logradouro := '0';
      Ds_Bairro := 'Centro';
      Ds_Complemento := 'Casa';
      Cd_Municipio := 1;
      Ds_Municipio := 'Cianorte';
      Cd_Estado := 1;
      Ds_Estado := 'Parana';
      Ds_SiglaEstado := 'PR';
      Cd_Pais := 1;
      Ds_Pais := 'Brasil';
      Ds_Fone := '04430191234';
      Ds_Celular := '044999881234';
      Ds_Email := 'teste@teste.com';
      In_Consumidorfinal := 'F';
    end;

  for I := 0 to vPessoas.Count - 1 do begin
    vPessoa := vPessoas[I];
    vPessoa.Nm_Pessoa := vPessoa.Nm_Pessoa + ' aletrado';
    vPessoa.Nm_Pessoa := vPessoa.Nm_Pessoa;
  end;

  vContexto := TmContexto.Create(nil);

  vTransacao := vContexto.GetObjeto(TTransacao, 'Cd_Dnatrans = ''AC77EFA3#20170421#160''') as TTransacao;
  vTransacao.Cd_Dnatrans := vTransacao.Cd_Dnatrans;
  vTransacao.Pessoa.Cd_Pessoa := vTransacao.Pessoa.Cd_Pessoa;
  TTransitem(vTransacao.Itens[0]).Cd_Produto := TTransitem(vTransacao.Itens[0]).Cd_Produto;
  TTransitem(vTransacao.Itens[0]).Produto.Cd_Barraprd := TTransitem(vTransacao.Itens[0]).Produto.Cd_Barraprd;

  vContexto.SetLista(vPessoas);

  vPessoas := vContexto.GetLista(TPessoa, 'Cd_Pessoa = 10', TPessoas) as TPessoas;
  vContexto.RemLista(vPessoas);
  vContexto.SetLista(vPessoas);

  vPessoa := vContexto.GetObjeto(TPessoa, 'Cd_Pessoa = 10') as TPessoa;
  vContexto.RemObjeto(vPessoa);
  vContexto.SetObjeto(vPessoa);

  vPessoa.Free;
  vTransacao.Free;

  vContexto.Free;

  ShowMessage('Testado com sucesso!');
end;

procedure TF_Persistent.BtnGerarClick(Sender: TObject);
begin
  TC_Persistent.gerar(MemoFiltro.Text);

  ShowMessage('Geracao efetuada com sucesso!');
end;

end.
