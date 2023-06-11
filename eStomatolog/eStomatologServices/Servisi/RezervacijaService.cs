using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
   
    public class RezervacijaService : BaseCRUDService<eStomatologModel.Rezervacija, Database.Rezervacija, BaseSearchObject, RezervacijaInsertRequest, RezervacijaInsertRequest>, IRezervacijeService
    {
        public RezervacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}
