﻿using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public partial class Ocjene
    {
        public int Id { get; set; }
        public int PacijentId { get; set; }
        public int DoktorId { get; set; }
        public DateTime Datum { get; set; }
        public int Ocjena { get; set; }
        public string Opis { get; set; }

        public virtual Pacijent Pacijent { get; set; } 
        public virtual Doktor Doktor { get; set; }

        public string PacijentIme => Pacijent?.Ime;
        public string PacijentPrezime => Pacijent?.Prezime;
        public string DoktorIme => Doktor?.Ime;
        public string DoktorPrezime => Doktor?.Prezime;
    }
}
