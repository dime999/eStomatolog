using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }

        public int DoktorId { get; set; }
        public virtual Doktor Doktor { get; set; }

        public int PacijentId { get; set; }
        public virtual Pacijent Pacijent { get; set; }

        public int OrdinacijaId { get; set; }
        public virtual Ordinacije Ordinacija { get; set; }

        public DateTime Od { get; set; }
        public DateTime Do { get; set; }
    }
}
