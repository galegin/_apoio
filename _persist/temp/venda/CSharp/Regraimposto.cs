using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("REGRAIMPOSTO")]
    public class Regraimposto : CollectionItem
    {
        [Campo("ID_REGRAFISCAL", CampoTipo.tfKey)]
        public int Id_Regrafiscal { get; set; }
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
        [Campo("PR_BASECALCULO", CampoTipo.tfReq)]
        public double Pr_Basecalculo { get; set; }
        [Campo("CD_CST", CampoTipo.tfReq)]
        public string Cd_Cst { get; set; }
        [Campo("CD_CSOSN", CampoTipo.tfNul)]
        public string Cd_Csosn { get; set; }
        [Campo("IN_ISENTO", CampoTipo.tfReq)]
        public string In_Isento { get; set; }
        [Campo("IN_OUTRO", CampoTipo.tfReq)]
        public string In_Outro { get; set; }
    }
}