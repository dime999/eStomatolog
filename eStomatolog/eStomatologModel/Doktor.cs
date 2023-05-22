﻿using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class Doktor
    {
        public int Id { get; set; }

        public int KorisnikId { get; set; }

        public string Ime { get; set; } = null;
        public string Prezime { get; set; } = null;

        public virtual ICollection<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }
        public virtual ICollection<Ordinacija> Ordinacije { get; set; }
    }
}
