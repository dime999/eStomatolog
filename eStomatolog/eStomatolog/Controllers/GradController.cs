using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{   
        public class GradController : BaseCRUDController<eStomatologModel.Grad, BaseSearchObject, GradUpsertRequest, GradUpsertRequest>
        {
            public GradController(IGradService service)
                : base(service)
            {

            }
        }
    }

