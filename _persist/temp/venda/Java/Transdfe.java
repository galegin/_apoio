package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSDFE")
public class Transdfe extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("NR_SEQUENCIA", CampoTipo.tfKey)
    public Integer Nr_Sequencia;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("TP_EVENTO", CampoTipo.tfReq)
    public Integer Tp_Evento;
    @Campo("TP_AMBIENTE", CampoTipo.tfReq)
    public Integer Tp_Ambiente;
    @Campo("TP_EMISSAO", CampoTipo.tfReq)
    public Integer Tp_Emissao;
    @Campo("DS_ENVIOXML", CampoTipo.tfReq)
    public String Ds_Envioxml;
    @Campo("DS_RETORNOXML", CampoTipo.tfNul)
    public String Ds_Retornoxml;
}