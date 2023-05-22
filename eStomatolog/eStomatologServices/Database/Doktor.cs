using eStomatologServices.Database;
using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Doktor
{

    public Doktor()
    {
        DoktoriSpecijalizacije = new HashSet<DoktoriSpecijalizacije>();
        Ordinacije = new HashSet<Ordinacija>();
    }


    public int Id { get; set; }

    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null;

    public string Prezime { get; set; } = null;


    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }
    public virtual ICollection<Ordinacija> Ordinacije { get; set; }
}
