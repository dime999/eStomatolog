using eStomatologServices.Database;
using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Doktor
{

    public Doktor()
    {

        DoktorOrdinacije = new HashSet<DoktorOrdinacija>();
        DoktoriSpecijalizacije = new HashSet<DoktoriSpecijalizacije>();

    }


    public int Id { get; set; }

    public int KorisnikId { get; set; }     
    public int GradId { get; set; }     

    public string Ime { get; set; } = null;

    public string Prezime { get; set; } = null;


    public virtual Korisnik Korisnik { get; set; } = null!;
    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<DoktorOrdinacija> DoktorOrdinacije { get; set; }
    public virtual ICollection<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }
}
