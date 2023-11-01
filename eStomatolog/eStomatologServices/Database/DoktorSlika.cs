using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    
    public class DoktorSlika
    {
        public int SlikaId { get; set; }
        public int DoktorId { get; set; }

        public virtual Doktor Doktor { get; set; }
        public virtual Slika Slika { get; set; }
    }
}
