using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("TERMINAL")]
    public class Terminal : CollectionItem
    {
        [Campo("ID_TERMINAL", CampoTipo.tfKey)]
        public int Id_Terminal { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_TERMINAL", CampoTipo.tfReq)]
        public int Cd_Terminal { get; set; }
        [Campo("DS_TERMINAL", CampoTipo.tfReq)]
        public string Ds_Terminal { get; set; }
    }
}