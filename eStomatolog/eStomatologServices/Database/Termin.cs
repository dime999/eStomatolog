using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Termin
{
    public int TerminId { get; set; }

    public int PacijentId { get; set; }

    public int DoktorId { get; set; }

    public int UslugaId { get; set; }

    public DateTime DatumVreme { get; set; }

    public string? Napomena { get; set; }

    public virtual Doktor Doktor { get; set; } = null!;

    public virtual Pacijent Pacijent { get; set; } = null!;

    public virtual Usluga Usluga { get; set; } = null!;
}
