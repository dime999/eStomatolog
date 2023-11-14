using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
        public class OrdinacijaController : BaseCRUDController<eStomatologModel.Ordinacije, BaseSearchObject, OrdinacijaUpsertRequest, OrdinacijaUpsertRequest>
        {
        private readonly IOrdinacijaService _service;
        public OrdinacijaController(IOrdinacijaService service)
                : base(service)
            {
            this._service= service;
            }

        [HttpGet("/getIzvjestaj/{id}")]
        public Izvjestaj GetIzvjestaj(int id)
        {
            var izvjestaj = _service.GetIzvjestaj(id);

            return izvjestaj;
        }

    }

}
