using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Database
{
    public class DoktorOrdinacija
    {
        
        public int DoktorId { get; set; }
        public Doktor Doktor { get; set; }

        
        public int OrdinacijaId { get; set; }
        public Ordinacija Ordinacija { get; set; }
    }
}
