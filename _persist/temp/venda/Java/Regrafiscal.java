package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("REGRAFISCAL")
public class Regrafiscal extends CollectionItem
{
    @Campo("ID_REGRAFISCAL", CampoTipo.tfKey)
    public Integer Id_Regrafiscal;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("DS_REGRAFISCAL", CampoTipo.tfReq)
    public String Ds_Regrafiscal;
    @Campo("IN_CALCIMPOSTO", CampoTipo.tfReq)
    public String In_Calcimposto;
}