using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eStomatologModel.Requests
{
    public class DijagnozaUpdateRequest
    {
        public DateTime Datum { get; set; }

        [MaxLength]
        public string Opis { get; set; }
    }
}
