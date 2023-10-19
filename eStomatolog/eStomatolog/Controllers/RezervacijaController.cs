using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
    public class RezervacijaController : BaseCRUDController<eStomatologModel.Rezervacija, RezervacijaSearchRequest, RezervacijaInsertRequest, RezervacijaInsertRequest>
    {
        public IRezervacijeService service { get; set; }
        public RezervacijaController(IRezervacijeService service)
            : base(service)
        {
            this.service = service;

        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetRezervacijeByOrdinacija/{id}")]
        public IEnumerable<eStomatologModel.Rezervacija> GetRezervacijeByOrdinacija(int id)
        {
            var rezervacije = service.GetByOrdinacijaId(id);
          

            return rezervacije;
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetRezervacijeByPacijent/{ordinacijaId}/{pacijentId}")]
        public IEnumerable<eStomatologModel.Rezervacija> GetRezervacijeByPacijent(int ordinacijaId,int pacijentId)
        {
            var rezervacije = service.GetByPacijentId(ordinacijaId,pacijentId);

            return rezervacije;
        }

    }
}
