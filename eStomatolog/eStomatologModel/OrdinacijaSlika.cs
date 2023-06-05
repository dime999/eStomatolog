using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class OrdinacijaSlika
    {
        public int SlikaId { get; set; }
        public int OrdinacijaId { get; set; }

        public virtual Ordinacije Ordinacija { get; set; }
        public virtual Slika Slika { get; set; }
    }
}
