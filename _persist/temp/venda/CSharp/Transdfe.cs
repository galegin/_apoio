using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSDFE")]
    public class Transdfe : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("NR_SEQUENCIA", CampoTipo.tfKey)]
        public int Nr_Sequencia { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("TP_EVENTO", CampoTipo.tfReq)]
        public int Tp_Evento { get; set; }
        [Campo("TP_AMBIENTE", CampoTipo.tfReq)]
        public int Tp_Ambiente { get; set; }
        [Campo("TP_EMISSAO", CampoTipo.tfReq)]
        public int Tp_Emissao { get; set; }
        [Campo("DS_ENVIOXML", CampoTipo.tfReq)]
        public string Ds_Envioxml { get; set; }
        [Campo("DS_RETORNOXML", CampoTipo.tfNul)]
        public string Ds_Retornoxml { get; set; }
    }
}