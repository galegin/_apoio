using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("PAIS")]
    public class Pais : CollectionItem
    {
        [Campo("ID_PAIS", CampoTipo.tfKey)]
        public int Id_Pais { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_PAIS", CampoTipo.tfReq)]
        public int Cd_Pais { get; set; }
        [Campo("DS_PAIS", CampoTipo.tfReq)]
        public string Ds_Pais { get; set; }
        [Campo("DS_SIGLA", CampoTipo.tfReq)]
        public string Ds_Sigla { get; set; }
    }
}