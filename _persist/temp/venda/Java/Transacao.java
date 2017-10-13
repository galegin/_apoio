package MORM.Java.Models;

import java.util.Date;
import MORM.Java.Classes;

@Tabela("TRANSACAO")
public class Transacao extends CollectionItem
{
    @Campo("ID_TRANSACAO", CampoTipo.tfKey)
    public String Id_Transacao;
    @Campo("U_VERSION", CampoTipo.tfNul)
    public String U_Version;
    @Campo("CD_OPERADOR", CampoTipo.tfReq)
    public Integer Cd_Operador;
    @Campo("DT_CADASTRO", CampoTipo.tfReq)
    public DateTime Dt_Cadastro;
    @Campo("ID_EMPRESA", CampoTipo.tfReq)
    public Integer Id_Empresa;
    @Campo("ID_PESSOA", CampoTipo.tfReq)
    public String Id_Pessoa;
    @Campo("ID_OPERACAO", CampoTipo.tfReq)
    public String Id_Operacao;
    @Campo("DT_TRANSACAO", CampoTipo.tfReq)
    public DateTime Dt_Transacao;
    @Campo("NR_TRANSACAO", CampoTipo.tfReq)
    public Integer Nr_Transacao;
    @Campo("TP_SITUACAO", CampoTipo.tfReq)
    public Integer Tp_Situacao;
    @Campo("DT_CANCELAMENTO", CampoTipo.tfNul)
    public DateTime Dt_Cancelamento;
}