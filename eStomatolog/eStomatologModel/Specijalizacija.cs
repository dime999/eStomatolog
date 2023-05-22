using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Specijalizacija
    {
        public int SpecijalizacijaId { get; set; }
        public string Naziv { get; set; }

        public virtual ICollection<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }
    }
}
