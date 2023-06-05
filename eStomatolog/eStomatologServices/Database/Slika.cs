using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Slika
    {
        public Slika()
        {
            OrdinacijaSlike = new HashSet<OrdinacijaSlika>();
        }

        public int SlikaId { get; set; }

        public string Path { get; set; }

        public virtual ICollection<OrdinacijaSlika> OrdinacijaSlike { get; set; }
    }
}
