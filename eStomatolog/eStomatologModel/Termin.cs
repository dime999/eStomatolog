using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Termin
    {
        public int TerminId { get; set; }

        public int PacijentId { get; set; }

        public int DoktorId { get; set; }

        public int UslugaId { get; set; }

        public DateTime DatumVrijeme { get; set; }

        public string Napomena { get; set; }
    }
}
