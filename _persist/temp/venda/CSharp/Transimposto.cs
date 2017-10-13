using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TRANSIMPOSTO")]
    public class Transimposto : CollectionItem
    {
        [Campo("ID_TRANSACAO", CampoTipo.tfKey)]
        public string Id_Transacao { get; set; }
        [Campo("NR_ITEM", CampoTipo.tfKey)]
        public int Nr_Item { get; set; }
        [Campo("CD_IMPOSTO", CampoTipo.tfKey)]
        public int Cd_Imposto { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("PR_ALIQUOTA", CampoTipo.tfReq)]
        public double Pr_Aliquota { get; set; }
        [Campo("VL_BASECALCULO", CampoTipo.tfReq)]
        public double Vl_Basecalculo { get; set; }
        [Campo("PR_BASECALCULO", CampoTipo.tfReq)]
        public double Pr_Basecalculo { get; set; }
        [Campo("PR_REDBASECALCULO", CampoTipo.tfReq)]
        public double Pr_Redbasecalculo { get; set; }
        [Campo("VL_IMPOSTO", CampoTipo.tfReq)]
        public double Vl_Imposto { get; set; }
        [Campo("VL_OUTRO", CampoTipo.tfReq)]
        public double Vl_Outro { get; set; }
        [Campo("VL_ISENTO", CampoTipo.tfReq)]
        public double Vl_Isento { get; set; }
        [Campo("CD_CST", CampoTipo.tfReq)]
        public string Cd_Cst { get; set; }
        [Campo("CD_CSOSN", CampoTipo.tfNul)]
        public string Cd_Csosn { get; set; }
    }
}