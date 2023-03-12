using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Dijagnoza
    {
        public int Id { get; set; }

        public int PacijentId { get; set; }

        public int DoktorId { get; set; }

        public DateTime Datum { get; set; }

        public string Opis { get; set; }

    }
}
