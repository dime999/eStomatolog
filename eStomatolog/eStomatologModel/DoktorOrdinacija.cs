using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DoktorOrdinacija
    {
        public int DoktorId { get; set; }
        public Doktor Doktor { get; set; }

        public int OrdinacijaId { get; set; }
        public Ordinacija Ordinacija { get; set; }
    }
}
