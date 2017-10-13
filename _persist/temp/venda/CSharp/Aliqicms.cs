using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("ALIQICMS")]
    public class Aliqicms : CollectionItem
    {
        [Campo("UF_ORIGEM", CampoTipo.tfKey)]
        public string Uf_Origem { get; set; }
        [Campo("UF_DESTINO", CampoTipo.tfKey)]
        public string Uf_Destino { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("PR_ALIQUOTA", CampoTipo.tfReq)]
        public double Pr_Aliquota { get; set; }
    }
}