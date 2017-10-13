using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("MUNICIPIO")]
    public class Municipio : CollectionItem
    {
        [Campo("ID_MUNICIPIO", CampoTipo.tfKey)]
        public int Id_Municipio { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_MUNICIPIO", CampoTipo.tfReq)]
        public int Cd_Municipio { get; set; }
        [Campo("DS_MUNICIPIO", CampoTipo.tfReq)]
        public string Ds_Municipio { get; set; }
        [Campo("DS_SIGLA", CampoTipo.tfReq)]
        public string Ds_Sigla { get; set; }
        [Campo("ID_ESTADO", CampoTipo.tfReq)]
        public int Id_Estado { get; set; }
    }
}