﻿using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class OrdinacijaUpsertRequest
    {
        public string Naziv { get; set; }

        public string Adresa { get; set; }

        public string Telefon { get; set; }

        public int GradId { get; set; }
    }
}
