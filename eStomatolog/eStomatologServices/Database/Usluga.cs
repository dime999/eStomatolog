using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Usluga
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public string Opis { get; set; } = null!;

    public decimal Cijena { get; set; }

    public virtual ICollection<Termin> Terminis { get; } = new List<Termin>();
}
