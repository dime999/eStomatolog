using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DoktoriSpecijalizacije
    {
        public int DoktorSpecijalizacijaId { get; set; }
        public int DoktorId { get; set; }
        public int SpecijalizacijaId { get; set; }


        public virtual Doktor Doktor { get; set; }
        public virtual Specijalizacija Specijalizacija { get; set; }

       

        public string SpecijalizacijaNaziv => Specijalizacija?.Naziv;
    }
}
