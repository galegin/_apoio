package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("PESSOA")
public class Pessoa extends CollectionItem
{
    @Campo("ID_PESSOA", CampoTipo.tfKey)
    public String Id_Pessoa;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_PESSOA", CampoTipo.tfReq)
    public Integer Cd_Pessoa;
    @Campo("NM_PESSOA", CampoTipo.tfReq)
    public String Nm_Pessoa;
    @Campo("NR_CPFCNPJ", CampoTipo.tfReq)
    public String Nr_Cpfcnpj;
    @Campo("NR_RGIE", CampoTipo.tfReq)
    public String Nr_Rgie;
    @Campo("NM_FANTASIA", CampoTipo.tfNul)
    public String Nm_Fantasia;
    @Campo("CD_CEP", CampoTipo.tfReq)
    public Integer Cd_Cep;
    @Campo("NM_LOGRADOURO", CampoTipo.tfReq)
    public String Nm_Logradouro;
    @Campo("NR_LOGRADOURO", CampoTipo.tfReq)
    public String Nr_Logradouro;
    @Campo("DS_BAIRRO", CampoTipo.tfReq)
    public String Ds_Bairro;
    @Campo("DS_COMPLEMENTO", CampoTipo.tfNul)
    public String Ds_Complemento;
    @Campo("CD_MUNICIPIO", CampoTipo.tfReq)
    public Integer Cd_Municipio;
    @Campo("DS_MUNICIPIO", CampoTipo.tfReq)
    public String Ds_Municipio;
    @Campo("CD_ESTADO", CampoTipo.tfReq)
    public Integer Cd_Estado;
    @Campo("DS_ESTADO", CampoTipo.tfReq)
    public String Ds_Estado;
    @Campo("DS_SIGLAESTADO", CampoTipo.tfReq)
    public String Ds_Siglaestado;
    @Campo("CD_PAIS", CampoTipo.tfReq)
    public Integer Cd_Pais;
    @Campo("DS_PAIS", CampoTipo.tfReq)
    public String Ds_Pais;
    @Campo("DS_FONE", CampoTipo.tfNul)
    public String Ds_Fone;
    @Campo("DS_CELULAR", CampoTipo.tfNul)
    public String Ds_Celular;
    @Campo("DS_EMAIL", CampoTipo.tfNul)
    public String Ds_Email;
    @Campo("IN_CONSUMIDORFINAL", CampoTipo.tfNul)
    public String In_Consumidorfinal;
}