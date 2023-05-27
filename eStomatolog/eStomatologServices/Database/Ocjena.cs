using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public partial class Ocjene
    {
        public int Id { get; set; }
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }

      //  public virtual Pacijent Pacijent { get; set; } = null!;
        public virtual Doktor Doktor { get; set; } = null!;
    }
}
