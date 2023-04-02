using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class VrsteUslugaController : BaseCRUDController<eStomatologModel.VrstaUsluge, VrstaUslugeSearchObject, VrstaUslugeUpsertRequest, VrstaUslugeUpsertRequest>
    {
        public VrsteUslugaController(IVrstaUslugeService service)
            : base(service)
        {

        }
    }
}
