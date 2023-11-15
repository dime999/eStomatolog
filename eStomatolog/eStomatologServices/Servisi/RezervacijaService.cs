using AutoMapper;
using EasyNetQ;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Account;
using Microsoft.VisualStudio.Services.Users;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
   
    public class RezervacijaService : BaseCRUDService<eStomatologModel.Rezervacija, Database.Rezervacija, RezervacijaSearchRequest, RezervacijaInsertRequest, RezervacijaInsertRequest>, IRezervacijeService
    {
        private readonly IMessageProducer _messageProducer;
        private readonly IPacijentService _pacijentService;
        private readonly IKorisniciService _korisniciService;
        private readonly IDoktorService _doktorService;
        private readonly ITerminService _terminService;
        private readonly IOrdinacijaService _ordinacijaService;
        public RezervacijaService(eStomatologContext context, IMapper mapper, IMessageProducer messageProducer, IPacijentService pacijentService, IKorisniciService korisniciService, IDoktorService doktorService,ITerminService terminService, IOrdinacijaService ordinacijaService) : base(context, mapper)
        {
            _messageProducer = messageProducer;
            _pacijentService = pacijentService;
            _korisniciService = korisniciService;
            _doktorService = doktorService;
            _terminService = terminService;
            _ordinacijaService= ordinacijaService;
        }

        public override IEnumerable<Rezervacija> Get(RezervacijaSearchRequest search = null)
        {
            var entity = Context.Set<eStomatologServices.Database.Rezervacija>().AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<Rezervacija>>(list);
        }

        public IEnumerable<Rezervacija> GetByPacijentId(int ordinacijaId,int pacijentId)
        {
            var Rezervacije = Context.Set<Database.Rezervacija>().Where(d => d.OrdinacijaId == ordinacijaId && d.PacijentId==pacijentId).Include(r => r.Doktor).Include(r => r.Pacijent).Include(t => t.Termin).Include(o => o.Ordinacija).AsQueryable();
            var list = Rezervacije.ToList();

            return Mapper.Map<IList<Rezervacija>>(list);
        }
        public IEnumerable<Rezervacija> GetByPacijent( int pacijentId)
        {
            var Rezervacije = Context.Set<Database.Rezervacija>().Where(d=> d.PacijentId == pacijentId).Include(r => r.Doktor).Include(r => r.Pacijent).Include(t => t.Termin).Include(o => o.Ordinacija).AsQueryable();
            var list = Rezervacije.ToList();

            return Mapper.Map<IList<Rezervacija>>(list);
        }

        public IEnumerable<Rezervacija> GetByOrdinacijaId(int id)
        {
            var Rezervacije = Context.Set<Database.Rezervacija>().Where(d => d.OrdinacijaId == id).Include(r => r.Doktor).Include(r => r.Pacijent).Include(t=>t.Termin).Include(o=>o.Ordinacija).AsQueryable();
            var list = Rezervacije.ToList();

            return Mapper.Map<IList<Rezervacija>>(list);
        }

        public IEnumerable<Rezervacija> DohvatiZauzeteTermine(int ordinacijaId, DateTime datum)
        {

            var Rezervacije = Context.Set<Database.Rezervacija>().Where(d => d.OrdinacijaId == ordinacijaId).Include(r => r.Doktor).Include(r => r.Ordinacija).Include(t => t.Termin).Where(r => r.OrdinacijaId == ordinacijaId && datum.Date==r.Datum.Date).AsQueryable();
            var list = Rezervacije.ToList();
            return Mapper.Map<IList<Rezervacija>>(list);
        }



        public override eStomatologModel.Rezervacija Insert(RezervacijaInsertRequest insert)
        {
            var entity = base.Insert(insert);
            string doktorIme = "";
            var pacijent = _pacijentService.GetById(entity.PacijentId);
            var doktor = _doktorService.GetById(entity.DoktorId);  
            var termin = _terminService.GetById(entity.TerminId);
            var ordinacija = _ordinacijaService.GetById(entity.OrdinacijaId);
            if (doktor != null)
            {
                doktorIme = doktor.Ime;
                entity.Doktor = doktor;
            }
            if(pacijent!= null)
            {
                entity.Pacijent = pacijent;
            }
            if (termin != null)
            {
                entity.Termin = termin;
            }
            if (ordinacija != null)
            {
                entity.Ordinacija = ordinacija;
            }
            Context.SaveChanges();

            if (entity != null)
            {
                eStomatologModel.ReservationNotifier reservation = new ReservationNotifier
                {
                    Id = entity.RezervacijaId,
                    DoktorIme = doktorIme,
                    Email = entity.Email,
                    Datum=entity.Datum,
                    Vrijeme=entity.Termin.Vrijeme

                };
                _messageProducer.SendingObject(reservation);
            }

            using var bus = RabbitHutch.CreateBus("host=localhost");

            bus.PubSub.Publish(entity);

            return entity;
        }

        public eStomatologModel.Rezervacija OznaciZauzet(RezervacijaInsertRequest insert)
        {
            var entity = base.Insert(insert);
            string doktorIme = "";
            var pacijent = _pacijentService.GetById(entity.PacijentId);
            var doktor = _doktorService.GetById(entity.DoktorId);
            var termin = _terminService.GetById(entity.TerminId);
            var ordinacija = _ordinacijaService.GetById(entity.OrdinacijaId);
            if (doktor != null)
            {
                doktorIme = doktor.Ime;
                entity.Doktor = doktor;
            }

            if (pacijent != null)
            {
                entity.Pacijent = pacijent;
            }

            if (termin != null)
            {
                entity.Termin = termin;
            }
            if (ordinacija != null)
            {
                entity.Ordinacija = ordinacija;
            }
            Context.SaveChanges();

           

            return entity;
        }

    }
}
