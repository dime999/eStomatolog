using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class RezervacijaController : BaseCRUDController<eStomatologModel.Rezervacija, BaseSearchObject, RezervacijaInsertRequest, RezervacijaInsertRequest>
    {
        public RezervacijaController(IRezervacijeService service)
            : base(service)
        {

        }
    }
}
