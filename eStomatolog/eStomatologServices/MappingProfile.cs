using AutoMapper;
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
            CreateMap<Models.Pacijent, eStomatologModel.Pacijent>();
            CreateMap<Models.Doktor, eStomatologModel.Doktor>();
            CreateMap<Models.Dijagnoza, eStomatologModel.Dijagnoza>();
            CreateMap<Models.Placanja, eStomatologModel.Placanja>();
            CreateMap<Models.Termin, eStomatologModel.Termin>();
            CreateMap<Models.Usluga, eStomatologModel.Usluga>();
            CreateMap<Models.Recept, eStomatologModel.Recept>();
            CreateMap<Database.VrstaUsluge, eStomatologModel.VrstaUsluge>();
            CreateMap<Database.Ordinacija, eStomatologModel.Ordinacija>();

            CreateMap<DijanozaInsertRequest,Models.Dijagnoza>();
            CreateMap<DijagnozaUpdateRequest, Models.Dijagnoza>();    
            CreateMap<eStomatologModel.Requests.VrstaUslugeUpsertRequest,eStomatologServices.Database.VrstaUsluge>();
            CreateMap<eStomatologModel.Requests.OrdinacijaUpsertRequest,eStomatologServices.Database.Ordinacija>();
        }

    }
}