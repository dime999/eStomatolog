using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Grad
    {
        public int GradId { get; set; }

        public string Naziv { get; set; }

        public List<Doktor> Doktori { get; set; }

        public List<Pacijent> Pacijenti { get; set; }

    }
}
