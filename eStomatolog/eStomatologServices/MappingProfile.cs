using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Models.Korisnik, eStomatologModel.Korisnik>();
            CreateMap<Database.Pacijent, eStomatologModel.Pacijent>();
            CreateMap<Models.Doktor, eStomatologModel.Doktor>();
            CreateMap<Models.Dijagnoza, eStomatologModel.Dijagnoza>();
            CreateMap<Models.Termin, eStomatologModel.Termin>();
            CreateMap<Models.Usluga, eStomatologModel.Usluga>();
            CreateMap<Database.VrstaUsluge, eStomatologModel.VrstaUsluge>();
            CreateMap<Database.Ordinacije, eStomatologModel.Ordinacije>();
            CreateMap<Database.Uloge, eStomatologModel.Uloge>();
            CreateMap<Database.Specijalizacija, eStomatologModel.Specijalizacija>();
            CreateMap<Database.Grad, eStomatologModel.Grad>();
            CreateMap<Database.DoktorOrdinacija, eStomatologModel.DoktorOrdinacija>();
            CreateMap<Database.DoktorOrdinacija, eStomatologModel.DoktorOrdinacijaDoktorInfo>();
            CreateMap<Database.DoktorOrdinacija, eStomatologModel.DoktorOrdinacijaOrdinacijaInfo>();
            CreateMap<Database.DoktoriSpecijalizacije, eStomatologModel.DoktoriSpecijalizacije>();
            CreateMap<Models.Dijagnoza, eStomatologModel.DijagnozaInfoModel>();
            CreateMap<Database.PacijentOrdinacija, eStomatologModel.PacijentOrdinacija>();
            CreateMap<Database.PacijentOrdinacija, eStomatologModel.OrdinacijaPacijent>();
            CreateMap<Database.Slika, eStomatologModel.Slika>();
            CreateMap<Database.OrdinacijaSlika, eStomatologModel.OrdinacijaSlika>();
            CreateMap<Database.Rezervacija, eStomatologModel.Rezervacija>();
            CreateMap<Database.PoklonBon, eStomatologModel.PoklonBon>();
            CreateMap<Database.Ocjene, eStomatologModel.Ocjene>();
            CreateMap<Database.KorisnikKartica, eStomatologModel.KorisnikKartica>();
            CreateMap<Models.Doktor, eStomatologModel.DoktorOrdinacijaDoktorInfo>();
            CreateMap<Models.Doktor, eStomatologModel.DoktorRecommended>();





            CreateMap<DijanozaInsertRequest,Models.Dijagnoza>();
            CreateMap<DijagnozaUpdateRequest, Models.Dijagnoza>();   
            CreateMap<SpecijalizacijaUpsertRequest, Database.Specijalizacija>();   
            CreateMap<GradUpsertRequest, Database.Grad>();   
            CreateMap<DoktorOrdinacija, Database.DoktorOrdinacija>();   
            CreateMap<DoktorOrdinacijaInsertRequest, Database.DoktorOrdinacija>();   
           
            
            CreateMap<eStomatologModel.Requests.VrstaUslugeUpsertRequest,eStomatologServices.Database.VrstaUsluge>();
            CreateMap<eStomatologModel.Requests.OrdinacijaUpsertRequest,eStomatologServices.Database.Ordinacije>();
            CreateMap<eStomatologModel.Requests.PacijentUpdateRequest,eStomatologServices.Database.Pacijent>();
            CreateMap<eStomatologModel.Requests.PoklonBonUpsertRequest, eStomatologServices.Database.PoklonBon>();
            CreateMap<eStomatologModel.Requests.OcjenaUpsertRequest, eStomatologServices.Database.Ocjene>();
            CreateMap<eStomatologModel.Requests.KorisnikKarticaUpsertRequest, eStomatologServices.Database.KorisnikKartica>();

            CreateMap<Database.KorisniciUloge, eStomatologModel.KorisniciUloge>();
            CreateMap<Database.Uloge, eStomatologModel.Uloge>();

            CreateMap<KorisniciInsertRequest, Models.Korisnik>();
            CreateMap<KorisniciUpdateRequest, Models.Korisnik>();
            CreateMap<SlikaInsertRequest, Database.Slika>();
            CreateMap<SlikaUpdateRequest, Database.Slika>();
            CreateMap<RezervacijaInsertRequest, Database.Rezervacija>();

      

        }

    }
}