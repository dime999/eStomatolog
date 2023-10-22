using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
    public class PoklonBonController : BaseCRUDController<eStomatologModel.PoklonBon, BaseSearchObject, PoklonBonUpsertRequest, PoklonBonUpsertRequest>
    {
        private readonly IPoklonBonService _service;


        public PoklonBonController(IPoklonBonService service)
            : base(service)
        {
            this._service = service;
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetPoklonBonByOrdinacija/{id}")]
        public IEnumerable<eStomatologModel.PoklonBon> GetRezervacijeByOrdinacija(int id)
        {
            var bonovi = _service.GetByOrdinacijaId(id);

            return bonovi;
        }


    }
}
