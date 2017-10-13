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
    ComboBoxTtipo: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnTestarClick(Sender: TObject);
  private
  public
  end;

var
  F_Persistent: TF_Persistent;

implementation

{$R *.dfm}

uses
  uclsPersistentAbstract,
  uclsPersistentCSharp,
  uclsPersistentDelphi,
  uclsPersistentDelphiXE,
  uclsPersistentJava,
  uclsPersistentPhp,
  mContexto, mIniFiles,
  mMapping, mCollection, mCollectionItem,
  uPessoa, uProduto, uTransacao, uTransitem;

procedure TF_Persistent.FormCreate(Sender: TObject);
begin
  with ComboBoxTtipo do begin
    Items.Clear;
    Items.AddObject('CSharp', TC_PersistentCSharp.Create);
    Items.AddObject('Delphi', TC_PersistentDelphi.Create);
    Items.AddObject('DelphiXE', TC_PersistentDelphiXE.Create);
    Items.AddObject('Java', TC_PersistentJava.Create);
    Items.AddObject('Php', TC_PersistentPhp.Create);
    ItemIndex := 0;
  end;

  MemoFiltro.Text := TmIniFiles.PegarS('', '', 'Lst_Entidade', '');
end;

procedure TF_Persistent.BtnGerarClick(Sender: TObject);
begin
  TmIniFiles.Setar('', '', 'Lst_Entidade', MemoFiltro.Text);

  with ComboBoxTtipo do
    TC_PersistentAbstract(Items.Objects[ItemIndex]).gerar(MemoFiltro.Text);

  ShowMessage('Geracao efetuada com sucesso!');
end;

procedure TF_Persistent.BtnTestarClick(Sender: TObject);
var
  vContexto : TmContexto;
  vPessoas : TPessoas;
  vPessoa : TPessoa;
  vTransacao : TTransacao;
  I : Integer;
begin
  vPessoas := TPessoas.Create(nil);

  for I := 1 to 10 do
    with vPessoas.Add do begin
      Id_Pessoa := IntToStr(I);
      U_Version := '';
      Cd_Operador := 1;
      Dt_Cadastro := Now;
      Nr_Cpfcnpj := IntToStr(I);
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

  vTransacao := vContexto.GetObjeto(TTransacao, 'Id_Transacao = ''AC77EFA3#20170421#16''') as TTransacao;
  vTransacao.Id_Transacao := vTransacao.Id_Transacao;
//  vTransacao.Pessoa.Id_Pessoa := vTransacao.Pessoa.Id_Pessoa;
//  vTransacao.Itens[0].Id_Produto := vTransacao.Itens[0].Id_Produto;
//  vTransacao.Itens[0].Produto.Id_Produto := vTransacao.Itens[0].Produto.Id_Produto;

  vContexto.SetLista(vPessoas);

  vPessoas := vContexto.GetLista(TPessoas, 'Cd_Pessoa = 10') as TPessoas;
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

end.
