using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class PacijentOrdinacija
    {
        public int PacijentId { get; set; }
        public Pacijent Pacijnet { get; set; }

        public int OrdinacijaId { get; set; }
        public Ordinacija Ordinacija { get; set; }
    }
}
