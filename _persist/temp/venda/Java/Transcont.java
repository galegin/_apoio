package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSCONT")
public class Transcont extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("TP_SITUACAO", CampoTipo.tfReq)
    public Integer Tp_Situacao;
    @Campo("CD_TERMINAL", CampoTipo.tfReq)
    public Integer Cd_Terminal;
}