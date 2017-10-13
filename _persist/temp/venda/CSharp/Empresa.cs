using MORM.CSharp.Classes;
using System;

namespace MORM.CSharp.Models
{
    [Tabela("EMPRESA")]
    public class Empresa : CollectionItem
    {
        [Campo("ID_EMPRESA", CampoTipo.tfKey)]
        public int Id_Empresa { get; set; }
        [Campo("U_VERSION", CampoTipo.tfNul)]
        public string U_Version { get; set; }
        [Campo("CD_OPERADOR", CampoTipo.tfReq)]
        public int Cd_Operador { get; set; }
        [Campo("DT_CADASTRO", CampoTipo.tfReq)]
        public DateTime Dt_Cadastro { get; set; }
        [Campo("ID_PESSOA", CampoTipo.tfReq)]
        public string Id_Pessoa { get; set; }
    }
}