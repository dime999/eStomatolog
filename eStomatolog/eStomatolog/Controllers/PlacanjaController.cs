using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class PlacanjaController : BaseController<eStomatologModel.Placanja, BaseSearchObject>
    {
        public PlacanjaController(IPlacanjaService service)
            : base(service)
        {
        }
    }
}
