using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Pacijent
{
    public int Id { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public DateTime DatumRodjenja { get; set; }

    public string Adresa { get; set; } = null!;

    public string BrojTelefona { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string? Napomene { get; set; }

    public virtual ICollection<Dijagnoza> Dijagnozes { get; } = new List<Dijagnoza>();

    public virtual ICollection<Placanja> Placanjas { get; } = new List<Placanja>();

    public virtual ICollection<Recept> Receptis { get; } = new List<Recept>();

    public virtual ICollection<Termin> Terminis { get; } = new List<Termin>();
}
