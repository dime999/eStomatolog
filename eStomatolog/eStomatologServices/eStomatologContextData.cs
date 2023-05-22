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
            modelBuilder.Entity<Models.Usluga>().HasData(new Models.Usluga { Id = 2, Naziv = "Popravka karijesa",Opis="Popravka karijesa uključuje brusenja zuba i stavljanje plombe",Cijena=50 });
            modelBuilder.Entity<Database.Ordinacija>().HasData(new Database.Ordinacija { Id = 1, Naziv = "Ordinacija 1",Adresa="Crkvice 40",Grad="Zenica",Drzava="Bosna i Hercegovina",Telefon="061111111" });
            modelBuilder.Entity<Database.Ordinacija>().HasData(new Database.Ordinacija { Id = 2, Naziv = "Ordinacija 2",Adresa="Hamida Vuka 41",Grad="Mostar",Drzava="Bosna i Hercegovina",Telefon="061111112" });

            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 2, Naziv = "Oralna hirurgija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 3, Naziv = "Ortodoncija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 4, Naziv = "Endodoncija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 5, Naziv = "Parodontologija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 6, Naziv = "Oralna patologija" });
        }


    }
}
