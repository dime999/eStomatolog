using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
  
    public class DoktorSlika
    {
        public int SlikaId { get; set; }
        public int DoktorId { get; set; }

        public virtual Doktor Doktor { get; set; }
        public virtual Slika Slika { get; set; }
    }
}
