package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSPAGTO")
public class Transpagto extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("NR_SEQ", CampoTipo.tfKey)
    public Integer Nr_Seq;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("ID_CAIXA", CampoTipo.tfReq)
    public Integer Id_Caixa;
    @Campo("TP_DOCUMENTO", CampoTipo.tfReq)
    public Integer Tp_Documento;
    @Campo("ID_HISTREL", CampoTipo.tfReq)
    public Integer Id_Histrel;
    @Campo("NR_PARCELA", CampoTipo.tfReq)
    public Integer Nr_Parcela;
    @Campo("NR_PARCELAS", CampoTipo.tfReq)
    public Integer Nr_Parcelas;
    @Campo("NR_DOCUMENTO", CampoTipo.tfNul)
    public Integer Nr_Documento;
    @Campo("VL_DOCUMENTO", CampoTipo.tfReq)
    public Float Vl_Documento;
    @Campo("DT_VENCIMENTO", CampoTipo.tfReq)
    public DateTime Dt_Vencimento;
    @Campo("CD_AUTORIZACAO", CampoTipo.tfNul)
    public String Cd_Autorizacao;
    @Campo("NR_NSU", CampoTipo.tfNul)
    public Integer Nr_Nsu;
    @Campo("DS_REDETEF", CampoTipo.tfNul)
    public String Ds_Redetef;
    @Campo("NM_OPERADORA", CampoTipo.tfNul)
    public String Nm_Operadora;
    @Campo("NR_BANCO", CampoTipo.tfNul)
    public Integer Nr_Banco;
    @Campo("NR_AGENCIA", CampoTipo.tfNul)
    public Integer Nr_Agencia;
    @Campo("DS_CONTA", CampoTipo.tfNul)
    public String Ds_Conta;
    @Campo("NR_CHEQUE", CampoTipo.tfNul)
    public Integer Nr_Cheque;
    @Campo("DS_CMC7", CampoTipo.tfNul)
    public String Ds_Cmc7;
    @Campo("TP_BAIXA", CampoTipo.tfNul)
    public Integer Tp_Baixa;
    @Campo("CD_OPERBAIXA", CampoTipo.tfNul)
    public Integer Cd_Operbaixa;
    @Campo("DT_BAIXA", CampoTipo.tfNul)
    public DateTime Dt_Baixa;
}