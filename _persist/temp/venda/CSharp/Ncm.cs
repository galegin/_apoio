using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("NCM")]
    public class Ncm : CollectionItem
    {
        [Campo("CD_NCM", CampoTipo.tfKey)]
        public string Cd_Ncm { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("DS_NCM", CampoTipo.tfReq)]
        public string Ds_Ncm { get; set; }
    }
}