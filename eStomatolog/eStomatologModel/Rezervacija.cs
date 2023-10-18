using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }
        public DateTime Datum { get; set; }
        public int TerminId { get; set; }
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }
        public int OrdinacijaId { get; set; }

    }
}
