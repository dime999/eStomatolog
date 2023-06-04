using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{

    public class PacijentOrdinacijaController : BaseCRUDController<eStomatologModel.PacijentOrdinacija, BaseSearchObject, PacijentOrdinacijaInsertRequest, PacijentOrdinacijaInsertRequest>
    {
        public IPacijentiOrdinacijeService service { get; set; }
        public PacijentOrdinacijaController(IPacijentiOrdinacijeService service)
            : base(service)
        {
            this.service = service;
        }


        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetPacijentiByOrdinacijaId/{id}")]
        public async Task<IEnumerable<PacijentOrdinacija>> GetPacijenti(int id)
        {
            var list = service.GetByOrdinacijaId(id);

            return list.ToList();
        }
    }
}
