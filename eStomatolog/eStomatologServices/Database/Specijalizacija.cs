using eStomatologModel;
using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class Specijalizacija
    {
        public Specijalizacija()
        {
            DoktoriSpecijalizacije = new HashSet<DoktoriSpecijalizacije>();
        }
        public int SpecijalizacijaId { get; set; }
        public string Naziv { get; set; } = null!;


        public virtual ICollection<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }

    }
}
