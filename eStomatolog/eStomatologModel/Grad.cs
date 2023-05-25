using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Grad
    {
        public int GradId { get; set; }

        public string Naziv { get; set; }

        public List<Doktor> Doktori { get; set; }
    }
}
