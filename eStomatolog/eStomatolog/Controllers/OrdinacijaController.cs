using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

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


        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpGet("/getIzvjestaj/{id}")]
        public Izvjestaj GetIzvjestaj(int id)
        {
            var izvjestaj = _service.GetIzvjestaj(id);

            return izvjestaj;
        }

    }

}
