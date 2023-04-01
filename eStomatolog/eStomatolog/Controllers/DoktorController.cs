using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
   
    public class DoktorController : BaseController<eStomatologModel.Doktor, BaseSearchObject>
    {
        public DoktorController(IDoktorService service)
            : base(service)
        {
        }
    }
}
