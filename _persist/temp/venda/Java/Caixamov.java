package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("CAIXAMOV")
public class Caixamov extends CollectionItem
{
    @Campo("ID_CAIXA", CampoTipo.tfKey)
    public Integer Id_Caixa;
    @Campo("NR_SEQ", CampoTipo.tfKey)
    public Integer Nr_Seq;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("TP_LANCTO", CampoTipo.tfReq)
    public Integer Tp_Lancto;
    @Campo("VL_LANCTO", CampoTipo.tfReq)
    public Float Vl_Lancto;
    @Campo("NR_DOC", CampoTipo.tfReq)
    public Integer Nr_Doc;
    @Campo("DS_AUX", CampoTipo.tfReq)
    public String Ds_Aux;
}