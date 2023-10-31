using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public partial class Ocjene
    {
        public int Id { get; set; }
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }

    }
}