using eStomatologServices.Database;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace eStomatologServices.Models;

public partial class Dijagnoza
{
    public int Id { get; set; }

    public int PacijentId { get; set; }

    public int DoktorId { get; set; }

    public DateTime Datum { get; set; }

    [Column(TypeName = "nvarchar(MAX)")]
    public string? Opis { get; set; }

    public virtual Doktor Doktor { get; set; } = null!;

    public virtual Pacijent Pacijent { get; set; } = null!;
}
