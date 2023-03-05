using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Dijagnoza
{
    public int Id { get; set; }

    public int PacijentId { get; set; }

    public int DoktorId { get; set; }

    public DateTime Datum { get; set; }

    public string? Opis { get; set; }

    public virtual Doktor Doktor { get; set; } = null!;

    public virtual Pacijent Pacijent { get; set; } = null!;
}
