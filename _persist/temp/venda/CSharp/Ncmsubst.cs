using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("NCMSUBST")]
    public class Ncmsubst : CollectionItem
    {
        [Campo("UF_ORIGEM", CampoTipo.tfKey)]
        public string Uf_Origem { get; set; }
        [Campo("UF_DESTINO", CampoTipo.tfKey)]
        public string Uf_Destino { get; set; }
        [Campo("CD_NCM", CampoTipo.tfKey)]
        public string Cd_Ncm { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfNul)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfNul)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_CEST", CampoTipo.tfNul)]
        public string Cd_Cest { get; set; }
    }
}