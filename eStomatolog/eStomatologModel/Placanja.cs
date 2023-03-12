using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Placanja
    {
        public int Id { get; set; }

        public int PacijentId { get; set; }

        public DateTime Datum { get; set; }

        public decimal Iznos { get; set; }

        public virtual Pacijent Pacijent { get; set; }
    }
}
