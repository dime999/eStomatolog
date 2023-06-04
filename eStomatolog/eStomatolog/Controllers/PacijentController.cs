using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using eStomatologServices.Servisi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class PacijentController : BaseCRUDController<eStomatologModel.Pacijent, PacijentSearchObject,PacijentUpdateRequest,PacijentUpdateRequest>
    {
        public PacijentController(IPacijentService service)
            : base(service)
        {
        }
    }
}
