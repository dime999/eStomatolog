using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class OcjenaUpsertRequest
    {
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }
        public string Opis { get; set; }

    }
}
