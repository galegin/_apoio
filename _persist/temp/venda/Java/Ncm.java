package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("NCM")
public class Ncm extends CollectionItem
{
    @Campo("CD_NCM", CampoTipo.tfKey)
    public String Cd_Ncm;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("DS_NCM", CampoTipo.tfReq)
    public String Ds_Ncm;
}