using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class DijagnozaUpdateRequest
    {
        public DateTime Datum { get; set; }

        public string Opis { get; set; }
    }
}
