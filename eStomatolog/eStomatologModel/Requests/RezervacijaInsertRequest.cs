﻿using System;
using System.Collections.Generic;
using System.Text;

namespace eStomatologModel.Requests
{
    public class RezervacijaInsertRequest
    {
        public int DoktorId { get; set; }
        public int PacijentId { get; set; }
        public int OrdinacijaId { get; set; }
        public DateTime Od { get; set; }
        public DateTime Do { get; set; }
    }
}