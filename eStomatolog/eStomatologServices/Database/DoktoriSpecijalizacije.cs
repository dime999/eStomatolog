using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class DoktoriSpecijalizacije
    {
        public int DoktorSpecijalizacijaId { get; set; }
        public int DoktorId { get; set; }
        public int SpecijalizacijaId { get; set; }


        public virtual Doktor Doktor { get; set; } = null!;
        public virtual Specijalizacija Specijalizacija { get; set; } = null!;
    }
}
