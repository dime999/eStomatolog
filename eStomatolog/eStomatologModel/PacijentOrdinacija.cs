using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class PacijentOrdinacija
    {
        public int PacijentId { get; set; }
        public Pacijent Pacijnet { get; set; }

        public int OrdinacijaId { get; set; }
        public Ordinacije Ordinacija { get; set; }
    }
}
