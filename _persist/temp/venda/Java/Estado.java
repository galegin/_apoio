package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("ESTADO")
public class Estado extends CollectionItem
{
    @Campo("ID_ESTADO", CampoTipo.tfKey)
    public Integer Id_Estado;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("CD_ESTADO", CampoTipo.tfReq)
    public Integer Cd_Estado;
    @Campo("DS_ESTADO", CampoTipo.tfReq)
    public String Ds_Estado;
    @Campo("DS_SIGLA", CampoTipo.tfReq)
    public String Ds_Sigla;
    @Campo("ID_PAIS", CampoTipo.tfReq)
    public Integer Id_Pais;
}