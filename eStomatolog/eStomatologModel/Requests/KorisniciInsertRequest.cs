﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace eStomatologModel.Requests
{
    public class KorisniciInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        public string Ime { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string Email { get; set; }
        [Required(AllowEmptyStrings = false)]
        public string Telefon { get; set; }

        [MinLength(4)]
        [Required(AllowEmptyStrings = false)]
        public string KorisnickoIme { get; set; }
        public string Password { get; set; }

        public string PasswordPotvrda { get; set; }

        public bool? Status { get; set; }

        public DateTime DatumRodjenja { get; set; }

        public List<int> UlogeIdList { get; set; } = new List<int> { };

        public List<int> SpecijalizacijeIdList { get; set; } = new List<int> { };

        public List<int> OrdinacijeIdList { get; set; } = new List<int> { };

        public int GradId { get; set; }
    }
}
