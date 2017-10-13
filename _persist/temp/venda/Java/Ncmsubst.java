package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("NCMSUBST")
public class Ncmsubst extends CollectionItem
{
    @Campo("UF_ORIGEM", CampoTipo.tfKey)
    public String Uf_Origem;
    @Campo("UF_DESTINO", CampoTipo.tfKey)
    public String Uf_Destino;
    @Campo("CD_NCM", CampoTipo.tfKey)
    public String Cd_Ncm;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfNul)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfNul)
    public DateTime Dt_Cadastro;
    @Campo("CD_CEST", CampoTipo.tfNul)
    public String Cd_Cest;
}