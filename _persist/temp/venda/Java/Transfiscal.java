package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSFISCAL")
public class Transfiscal extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("TP_OPERACAO", CampoTipo.tfReq)
    public Integer Tp_Operacao;
    @Campo("TP_MODALIDADE", CampoTipo.tfReq)
    public Integer Tp_Modalidade;
    @Campo("TP_MODELONF", CampoTipo.tfReq)
    public Integer Tp_Modelonf;
    @Campo("CD_SERIE", CampoTipo.tfReq)
    public String Cd_Serie;
    @Campo("NR_NF", CampoTipo.tfReq)
    public Integer Nr_Nf;
    @Campo("TP_PROCESSAMENTO", CampoTipo.tfReq)
    public String Tp_Processamento;
    @Campo("DS_CHAVEACESSO", CampoTipo.tfNul)
    public String Ds_Chaveacesso;
    @Campo("DT_RECEBIMENTO", CampoTipo.tfNul)
    public DateTime Dt_Recebimento;
    @Campo("NR_RECIBO", CampoTipo.tfNul)
    public String Nr_Recibo;
}