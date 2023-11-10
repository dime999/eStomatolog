using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eStomatologModel
{
    public class Dijagnoza
    {
        public int Id { get; set; }

        public int PacijentId { get; set; }

        public int DoktorId { get; set; }

        public DateTime Datum { get; set; }

        [MaxLength]
        public string Opis { get; set; }

    }
}
