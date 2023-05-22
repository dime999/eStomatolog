using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class SpecijalizacijaUpsertRequest
    {
        public string Naziv { get; set; }

        public virtual ICollection<Doktor> Doktori { get; set; }
    }
}
