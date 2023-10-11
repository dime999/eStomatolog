using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class DoktorUpsertRequest
    {
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public List<int> SpecijalizacijeIdList { get; set; } = new List<int> { };

        public List<int> OrdinacijeIdList { get; set; } = new List<int> { };

    }
}
