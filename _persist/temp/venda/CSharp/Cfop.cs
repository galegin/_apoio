using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("CFOP")]
    public class Cfop : CollectionItem
    {
        [Campo("CD_CFOP", CampoTipo.tfKey)]
        public int Cd_Cfop { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("DS_CFOP", CampoTipo.tfReq)]
        public string Ds_Cfop { get; set; }
    }
}