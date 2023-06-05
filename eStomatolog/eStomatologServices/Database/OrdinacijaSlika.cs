using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class OrdinacijaSlika
    {
        public int SlikaId { get; set; }
        public int OrdinacijaId { get; set; }

        public virtual Ordinacije Ordinacija { get; set; }
        public virtual Slika Slika { get; set; }
    }
}
