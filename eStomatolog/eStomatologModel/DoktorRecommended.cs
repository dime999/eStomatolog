using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    

    public class DoktorRecommended
    {
        public int Id { get; set; }

        public int KorisnikId { get; set; }
        public int GradId { get; set; }


        public string Ime { get; set; } = null;
        public string Prezime { get; set; } = null;

        public List<int> Ocjene { get; set; } = new List<int>();


    }
}



