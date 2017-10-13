using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("ESTADO")]
    public class Estado : CollectionItem
    {
        [Campo("ID_ESTADO", CampoTipo.tfKey)]
        public int Id_Estado { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("CD_ESTADO", CampoTipo.tfReq)]
        public int Cd_Estado { get; set; }
        [Campo("DS_ESTADO", CampoTipo.tfReq)]
        public string Ds_Estado { get; set; }
        [Campo("DS_SIGLA", CampoTipo.tfReq)]
        public string Ds_Sigla { get; set; }
        [Campo("ID_PAIS", CampoTipo.tfReq)]
        public int Id_Pais { get; set; }
    }
}