package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("CFOP")
public class Cfop extends CollectionItem
{
    @Campo("CD_CFOP", CampoTipo.tfKey)
    public Integer Cd_Cfop;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("DS_CFOP", CampoTipo.tfReq)
    public String Ds_Cfop;
}