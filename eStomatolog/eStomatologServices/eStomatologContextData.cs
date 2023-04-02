using eStomatologModel;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices
{
    partial class eStomatologContext
    {
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {    
            modelBuilder.Entity<Database.VrstaUsluge>().HasData(new Database.VrstaUsluge { VrstaUslugeId = 1, Naziv = "Redovno cišcenje zuba" });
            modelBuilder.Entity<Database.VrstaUsluge>().HasData(new Database.VrstaUsluge { VrstaUslugeId = 2, Naziv = "Popravka karijesa" });
            modelBuilder.Entity<Database.VrstaUsluge>().HasData(new Database.VrstaUsluge { VrstaUslugeId = 3, Naziv = "Izbeljivanje zuba pomocu gela" });
        }


    }
}
