using eStomatologModel;
using eStomatologServices.Database;
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

            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 1, Naziv = "Oralna hirurgija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 2, Naziv = "Ortodoncija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 3, Naziv = "Endodoncija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 4, Naziv = "Parodontologija" });
            modelBuilder.Entity<Database.Specijalizacija>().HasData(new Database.Specijalizacija { SpecijalizacijaId = 5, Naziv = "Oralna patologija" });

            modelBuilder.Entity<Database.Grad>().HasData(new Database.Grad { GradId = 1, Naziv = "Zenica" });
            modelBuilder.Entity<Database.Grad>().HasData(new Database.Grad { GradId = 2, Naziv = "Sarajevo" });
            modelBuilder.Entity<Database.Grad>().HasData(new Database.Grad { GradId = 3, Naziv = "Mostar" });

            modelBuilder.Entity<Database.Uloge>().HasData(new Database.Uloge { UlogaId = 1, Naziv = "Administrator", Opis = "Administrator" });
            modelBuilder.Entity<Database.Uloge>().HasData(new Database.Uloge { UlogaId = 2, Naziv = "Korisnik", Opis = "Korisnik" });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 1,
                Ime = "Desktop",
                Prezime = "Desktop",
                Email = "desktop.desktop@example.com",
                Telefon = "0622227892",
                KorisnickoIme = "desktop",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 2,
                Ime = "Adem",
                Prezime = "Halilovic",
                Email = "adem.halilovic@gmail.com",
                Telefon = "0622227892",
                KorisnickoIme = "adem",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 3,
                Ime = "Kenan",
                Prezime = "Cosic",
                Email = "kenan.cosic@gmail.com",
                Telefon = "0622527892",
                KorisnickoIme = "kenan",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 4,
                Ime = "Mobile",
                Prezime = "Mobile",
                Email = "mobile.mobile@example.com",
                Telefon = "0622227822",
                KorisnickoIme = "mobile",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 5,
                Ime = "Enes",
                Prezime = "Talic",
                Email = "enes.talic@gmail.com",
                Telefon = "0627877822",
                KorisnickoIme = "enes",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<eStomatologServices.Models.Korisnik>().HasData(new eStomatologServices.Models.Korisnik
            {
                KorisnikId = 6,
                Ime = "Salih",
                Prezime = "Buro",
                Email = "salih.buro@gmail.com",
                Telefon = "062765822",
                KorisnickoIme = "salih",
                LozinkaHash = "PQ570hFK9Bu43Qw4qZ2wLAisk4c=",
                LozinkaSalt = "RDcOKBdT86HOJAuigS+J0A==",
                Status = true
            });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 1, KorisnikId = 1, UlogaId = 1, DatumIzmjene = DateTime.Now });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 2, KorisnikId = 2, UlogaId = 1, DatumIzmjene = DateTime.Now });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 3, KorisnikId = 3, UlogaId = 1, DatumIzmjene = DateTime.Now });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 4, KorisnikId = 4, UlogaId = 2, DatumIzmjene = DateTime.Now });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 5, KorisnikId = 5, UlogaId = 2, DatumIzmjene = DateTime.Now });
            modelBuilder.Entity<Database.KorisniciUloge>().HasData(new Database.KorisniciUloge { KorisnikUlogaId = 6, KorisnikId = 6, UlogaId = 2, DatumIzmjene = DateTime.Now });

            modelBuilder.Entity<Database.Ordinacije>().HasData(new Database.Ordinacije { OrdinacijaId = 1, Naziv = "Ordinacija1", Adresa = "Crkvice 40", Telefon = "0603422323", GradId = 1 });
            modelBuilder.Entity<Database.Ordinacije>().HasData(new Database.Ordinacije { OrdinacijaId = 2, Naziv = "Ordinacija2", Adresa = "Crkvice 41", Telefon = "0603422324", GradId = 2 });
            modelBuilder.Entity<Database.Ordinacije>().HasData(new Database.Ordinacije { OrdinacijaId = 3, Naziv = "Ordinacija3", Adresa = "Crkvice 442", Telefon = "0603422325", GradId = 3 });

            modelBuilder.Entity<eStomatologServices.Models.Doktor>().HasData(new eStomatologServices.Models.Doktor { Id = 1, KorisnikId = 1, GradId = 1, Ime = "Desktop", Prezime = "Desktop" });
            modelBuilder.Entity<eStomatologServices.Models.Doktor>().HasData(new eStomatologServices.Models.Doktor { Id = 2, KorisnikId = 2, GradId = 2, Ime = "Adem", Prezime = "Halilovic" });
            modelBuilder.Entity<eStomatologServices.Models.Doktor>().HasData(new eStomatologServices.Models.Doktor { Id = 3, KorisnikId = 3, GradId = 3, Ime = "Kenan", Prezime = "Cosic" });

            modelBuilder.Entity<Database.Pacijent>().HasData(new Database.Pacijent { Id = 1, KorisnikId = 4, GradId = 1, Ime = "Mobile", Prezime = "Mobile", Telefon = "062222732" });
            modelBuilder.Entity<Database.Pacijent>().HasData(new Database.Pacijent { Id = 2, KorisnikId = 5, GradId = 2, Ime = "Enes", Prezime = "Talic", Telefon = "062222732" });
            modelBuilder.Entity<Database.Pacijent>().HasData(new Database.Pacijent { Id = 3, KorisnikId = 6, GradId = 3, Ime = "Salih", Prezime = "Buro", Telefon = "063422732" });

            modelBuilder.Entity<Database.DoktoriSpecijalizacije>().HasData(new Database.DoktoriSpecijalizacije { DoktorSpecijalizacijaId = 1, DoktorId = 1, SpecijalizacijaId = 1 });
            modelBuilder.Entity<Database.DoktoriSpecijalizacije>().HasData(new Database.DoktoriSpecijalizacije { DoktorSpecijalizacijaId = 4, DoktorId = 1, SpecijalizacijaId = 2 });
            modelBuilder.Entity<Database.DoktoriSpecijalizacije>().HasData(new Database.DoktoriSpecijalizacije { DoktorSpecijalizacijaId = 2, DoktorId = 2, SpecijalizacijaId = 2 });
            modelBuilder.Entity<Database.DoktoriSpecijalizacije>().HasData(new Database.DoktoriSpecijalizacije { DoktorSpecijalizacijaId = 3, DoktorId = 3, SpecijalizacijaId = 3 });


            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 1, DoktorId = 1 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 2, DoktorId = 1 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 3, DoktorId = 1 });

            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 1, DoktorId = 2 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 2, DoktorId = 2 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 3, DoktorId = 2 });

            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 1, DoktorId = 3 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 2, DoktorId = 3 });
            modelBuilder.Entity<Database.DoktorOrdinacija>().HasData(new Database.DoktorOrdinacija { OrdinacijaId = 3, DoktorId = 3 });


            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 1, PacijentId = 1 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 2, PacijentId = 1 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 3, PacijentId = 1 });

            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 1, PacijentId = 2 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 2, PacijentId = 2 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 3, PacijentId = 2 });

            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 1, PacijentId = 3 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 2, PacijentId = 3 });
            modelBuilder.Entity<Database.PacijentOrdinacija>().HasData(new Database.PacijentOrdinacija { OrdinacijaId = 3, PacijentId = 3 });


            DateTime startDate = new DateTime(1900, 1, 1, 8, 0, 0);

            for (int i = 0; i < 17; i++)
            {
                modelBuilder.Entity<eStomatologServices.Models.Termin>().HasData(new eStomatologServices.Models.Termin
                {
                    TerminId=i+1,
                    Vrijeme = startDate.AddMinutes(i * 30)
                });
            }
            modelBuilder.Entity<Database.Slika>().HasData(
            new Database.Slika { SlikaId = 1, Path = @"C:\Code\FIT-RS2-2023\eStomatolog\eStomatolog\images/klinika1232424109.jpg" },
            new Database.Slika { SlikaId = 2, Path = @"C:\Code\FIT-RS2-2023\eStomatolog\eStomatolog\images/klinika2232404361.jpg" },
            new Database.Slika { SlikaId = 3, Path = @"C:\Code\FIT-RS2-2023\eStomatolog\eStomatolog\images/klinika2232321330.jpg" }
        );

            modelBuilder.Entity<Database.OrdinacijaSlika>().HasData(new Database.OrdinacijaSlika { OrdinacijaId = 1, SlikaId = 1 });
            modelBuilder.Entity<Database.OrdinacijaSlika>().HasData(new Database.OrdinacijaSlika { OrdinacijaId = 2, SlikaId = 2 });
            modelBuilder.Entity<Database.OrdinacijaSlika>().HasData(new Database.OrdinacijaSlika { OrdinacijaId = 3, SlikaId = 3 });

            modelBuilder.Entity<eStomatologServices.Models.Dijagnoza>().HasData(new eStomatologServices.Models.Dijagnoza { Id = 1, PacijentId = 1, DoktorId = 1, Datum=DateTime.Now,Opis= "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina." });
            modelBuilder.Entity<eStomatologServices.Models.Dijagnoza>().HasData(new eStomatologServices.Models.Dijagnoza { Id = 2, PacijentId = 2, DoktorId = 2, Datum = DateTime.Now, Opis = "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina." });
            modelBuilder.Entity<eStomatologServices.Models.Dijagnoza>().HasData(new eStomatologServices.Models.Dijagnoza { Id = 3, PacijentId = 3, DoktorId = 3, Datum = DateTime.Now, Opis = "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina." });

            modelBuilder.Entity<Database.PoklonBon>().HasData(new Database.PoklonBon { PoklonBonId = 1, Kod = "123456",IznosPlacanja=50,PacijentId=1,ImePrezimeKorisnikaKojiKoristi="Adem Halilovic",Placeno=true,BrojKartice="",DatumIstekaKartice=DateTime.Now,CvcCvvKod="",OrdinacijaId=1,Iskoristeno=false });
            modelBuilder.Entity<Database.PoklonBon>().HasData(new Database.PoklonBon { PoklonBonId = 2, Kod = "123456", IznosPlacanja = 100, PacijentId = 2, ImePrezimeKorisnikaKojiKoristi = "Adem Halilovic", Placeno = true, BrojKartice = "", DatumIstekaKartice = DateTime.Now, CvcCvvKod = "", OrdinacijaId = 2, Iskoristeno = true });
            modelBuilder.Entity<Database.PoklonBon>().HasData(new Database.PoklonBon { PoklonBonId = 3, Kod = "123456", IznosPlacanja = 50, PacijentId = 3, ImePrezimeKorisnikaKojiKoristi = "Adem Halilovic", Placeno = true, BrojKartice = "", DatumIstekaKartice = DateTime.Now, CvcCvvKod = "", OrdinacijaId = 3, Iskoristeno = false });


            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id=1,PacijentId = 1, DoktorId = 1,Datum=DateTime.Now,Ocjena=5,Opis= "Jako komunikativan doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 2, PacijentId = 1, DoktorId = 2, Datum = DateTime.Now, Ocjena = 5, Opis = "Najbolji doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 3, PacijentId = 1, DoktorId = 3, Datum = DateTime.Now, Ocjena = 5, Opis = "Jako komunikativan doktor." });

            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 4, PacijentId = 2, DoktorId = 1, Datum = DateTime.Now, Ocjena = 3, Opis = "Dobar doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 5, PacijentId = 2, DoktorId = 2, Datum = DateTime.Now, Ocjena = 4, Opis = "Najbolji doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 6, PacijentId = 2, DoktorId = 3, Datum = DateTime.Now, Ocjena = 5, Opis = "Jako komunikativan doktor." });

            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 7, PacijentId = 3, DoktorId = 1, Datum = DateTime.Now, Ocjena = 3, Opis = "Jako komunikativan doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 8, PacijentId = 3, DoktorId = 2, Datum = DateTime.Now, Ocjena = 4, Opis = "Najbolji doktor." });
            modelBuilder.Entity<Database.Ocjene>().HasData(new Database.Ocjene { Id = 9, PacijentId = 3, DoktorId = 3, Datum = DateTime.Now, Ocjena = 5, Opis = "Jako komunikativan doktor." });

            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 1, PacijentId = 1, DoktorId = 1, Datum = DateTime.Now, TerminId = 2, OrdinacijaId = 1, Email = "" });
            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 2, PacijentId = 1, DoktorId = 1, Datum = DateTime.Now, TerminId = 3, OrdinacijaId = 1, Email = "" });
            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 3, PacijentId = 1, DoktorId = 1, Datum = DateTime.Now, TerminId = 4, OrdinacijaId = 1, Email = "" });

            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 4, PacijentId = 2, DoktorId = 2, Datum = DateTime.Now, TerminId = 3, OrdinacijaId = 2, Email = "" });
            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 5, PacijentId = 2, DoktorId = 2, Datum = DateTime.Now, TerminId = 4, OrdinacijaId = 2, Email = "" });
            modelBuilder.Entity<Database.Rezervacija>().HasData(new Database.Rezervacija { RezervacijaId = 6, PacijentId = 2, DoktorId = 2, Datum = DateTime.Now, TerminId = 5, OrdinacijaId = 1, Email = "" });


        }

    }

    }
