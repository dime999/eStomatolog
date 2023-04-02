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
    public class OrdinacijaService : BaseCRUDService<eStomatologModel.Ordinacija, Database.Ordinacija, BaseSearchObject, OrdinacijaUpsertRequest, OrdinacijaUpsertRequest>, IOrdinacijaService
    {
        public OrdinacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
