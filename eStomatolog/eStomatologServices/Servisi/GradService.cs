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

    public class GradService : BaseCRUDService<eStomatologModel.Grad, Database.Grad, BaseSearchObject, GradUpsertRequest, GradUpsertRequest>, IGradService
    {
        public GradService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}
