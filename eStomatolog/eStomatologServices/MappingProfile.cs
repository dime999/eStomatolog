using AutoMapper;
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
        }

    }
}