using eStomatologServices.Database;
using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Doktor
{
    public int Id { get; set; }

    public int KorisnikId { get; set; }

    public string Specijalnost { get; set; } = null!;

    public string Ime { get; set; } = null;
    public string Prezime { get; set; } = null;


    public virtual Korisnik Korisnik { get; set; }

    public virtual ICollection<Dijagnoza> Dijagnozes { get; } = new List<Dijagnoza>();

    public virtual ICollection<Recept> Receptis { get; } = new List<Recept>();

    public virtual ICollection<Termin> Terminis { get; } = new List<Termin>();

    public virtual ICollection<Ocjene> Ocjene { get; } = new List<Ocjene>();
}
