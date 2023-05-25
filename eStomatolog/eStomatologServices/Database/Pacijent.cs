using eStomatologModel;
using eStomatologServices.Database;
using System;
using System.Collections.Generic;
using Ordinacija = eStomatologServices.Database.Ordinacija;

namespace eStomatologServices.Models;

public partial class Pacijent
{

    public Pacijent()
    {
        Ordinacije = new HashSet<Ordinacija>();
    }
    public int PacijentId { get; set; }

    public int KorisnikId { get; set; }

    public int GradId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public DateTime DatumRodjenja { get; set; }

    public string BrojTelefona { get; set; } = null!;

    public string Email { get; set; } = null!;

    public virtual Korisnik Korisnik { get; set; } = null!;
    public virtual Database.Grad Grad { get; set; } = null!;



    public virtual ICollection<Ordinacija> Ordinacije { get; set; }
}
