package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("ALIQICMS")
public class Aliqicms extends CollectionItem
{
    @Campo("UF_ORIGEM", CampoTipo.tfKey)
    public String Uf_Origem;
    @Campo("UF_DESTINO", CampoTipo.tfKey)
    public String Uf_Destino;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("PR_ALIQUOTA", CampoTipo.tfReq)
    public Float Pr_Aliquota;
}