using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class UslugaController : BaseController<eStomatologModel.Usluga, BaseSearchObject>
    {
        public UslugaController(IUslugaService service)
            : base(service)
        {
        }
    }
}
