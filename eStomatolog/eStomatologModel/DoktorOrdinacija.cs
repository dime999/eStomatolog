﻿using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel
{
    public class DoktorOrdinacija
    {
        
        public Ordinacija Ordinacija { get; set; }


        public string OrdinacijaNaziv => Ordinacija?.Naziv;
       
        public string OrdinacijaAdresa => Ordinacija?.Adresa;
    }
}
