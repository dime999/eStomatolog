using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using eStomatologServices.Servisi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class PacijentController : BaseController<eStomatologModel.Pacijent, PacijentSearchObject>
    {
        public PacijentController(IPacijentService service)
            : base(service)
        {
        }
    }
}
