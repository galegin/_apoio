using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSINUT")]
    public class Transinut : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("DT_EMISSAO", CampoTipo.tfReq)]
        public DateTime Dt_Emissao { get; set; }
        [Campo("TP_MODELONF", CampoTipo.tfReq)]
        public int Tp_Modelonf { get; set; }
        [Campo("CD_SERIE", CampoTipo.tfReq)]
        public string Cd_Serie { get; set; }
        [Campo("NR_NF", CampoTipo.tfReq)]
        public int Nr_Nf { get; set; }
        [Campo("DT_RECEBIMENTO", CampoTipo.tfNul)]
        public DateTime Dt_Recebimento { get; set; }
        [Campo("NR_RECIBO", CampoTipo.tfNul)]
        public string Nr_Recibo { get; set; }
    }
}