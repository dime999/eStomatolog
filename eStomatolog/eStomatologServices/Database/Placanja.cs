using System;
using System.Collections.Generic;

namespace eStomatologServices.Models;

public partial class Placanja
{
    public int Id { get; set; }

    public int PacijentId { get; set; }

    public DateTime Datum { get; set; }

    public decimal Iznos { get; set; }

  //  public virtual Pacijent Pacijent { get; set; } = null!;
}
