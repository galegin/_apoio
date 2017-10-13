package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("HISTREL")
public class Histrel extends CollectionItem
{
    @Campo("ID_HISTREL", CampoTipo.tfKey)
    public Integer Id_Histrel;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("TP_DOCUMENTO", CampoTipo.tfReq)
    public Integer Tp_Documento;
    @Campo("CD_HISTREL", CampoTipo.tfReq)
    public Integer Cd_Histrel;
    @Campo("DS_HISTREL", CampoTipo.tfReq)
    public String Ds_Histrel;
    @Campo("NR_PARCELAS", CampoTipo.tfReq)
    public Integer Nr_Parcelas;
}