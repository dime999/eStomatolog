using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class RezervacijaInsertRequest
    {
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }
        public int OrdinacijaId { get; set; }
        public int TerminId { get; set; }
        public DateTime Datum { get; set; }
    }
}
