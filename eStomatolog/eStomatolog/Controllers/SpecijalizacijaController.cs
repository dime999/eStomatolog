using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    
        public class SpecijalizacijaController : BaseController<eStomatologModel.Specijalizacija, BaseSearchObject>
        {
            public SpecijalizacijaController(ISpecijalizacijaService service)
                : base(service)
            {
            }
        }
    
}
