using AutoMapper;
using eStomatologModel;
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
        [HttpPost("/OznaciZauzetim")]
        public eStomatologModel.Rezervacija OznaciZauzetim(RezervacijaInsertRequest request)
        {
            var rezervacije = service.OznaciZauzet(request);


            return rezervacije;
        }



        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetRezervacijeByOrdinacija/{id}")]
        public IEnumerable<eStomatologModel.Rezervacija> GetRezervacijeByOrdinacija(int id)
        {
            var rezervacije = service.GetByOrdinacijaId(id);
          

            return rezervacije;
        }

        [HttpGet("/GetRezervacijeByPacijent/{ordinacijaId}/{pacijentId}")]
        public IEnumerable<eStomatologModel.Rezervacija> GetRezervacijeByPacijent(int ordinacijaId,int pacijentId)
        {
            var rezervacije = service.GetByPacijentId(ordinacijaId,pacijentId);

            return rezervacije;
        }
        [HttpGet("/Get/{pacijentId}")]
        public IEnumerable<eStomatologModel.Rezervacija> GetByPacijent(int pacijentId)
        {
            var rezervacije = service.GetByPacijent(pacijentId);

            return rezervacije;
        }


        [HttpGet]
        [Route("zauzeti-termini")]
        public IEnumerable<eStomatologModel.Rezervacija> GetZauzetiTermini(int ordinacijaId, DateTime datum)
        { 
            var rezervacije = service.DohvatiZauzeteTermine(ordinacijaId, datum);

            return rezervacije;
        }

    }
}
