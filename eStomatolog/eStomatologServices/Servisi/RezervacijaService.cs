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
        public RezervacijaService(eStomatologContext context, IMapper mapper, IMessageProducer messageProducer, IPacijentService pacijentService, IKorisniciService korisniciService, IDoktorService doktorService) : base(context, mapper)
        {
            _messageProducer = messageProducer;
            _pacijentService = pacijentService;
            _korisniciService = korisniciService;
            _doktorService = doktorService;
        }

        public override IEnumerable<Rezervacija> Get(RezervacijaSearchRequest search = null)
        {
            var entity = Context.Set<eStomatologServices.Database.Rezervacija>().Include(pac => pac.Pacijent).Include(dok=> dok.Doktor).Include(ord=> ord.Ordinacija).AsQueryable();
            var list = entity.ToList();
            return Mapper.Map<IList<Rezervacija>>(list);
        }

        public override eStomatologModel.Rezervacija Insert(RezervacijaInsertRequest insert)
        {
            var entity = base.Insert(insert);
            string email = "";
            string doktorIme = "";
           

            var pacijent = _pacijentService.GetById(entity.PacijentId);
            var doktor = _doktorService.GetById(entity.DoktorId);

            if(pacijent!=null)
            {
                var korisnik = _korisniciService.GetById(pacijent.KorisnikId);

                if (korisnik != null)
                {
                    email=korisnik.Email;
                }

            }
            if (doktor != null)
            {
                doktorIme = doktor.Ime;
            }

            if (entity != null)
            {
                eStomatologModel.ReservationNotifier reservation = new ReservationNotifier
                {
                    Id = entity.RezervacijaId,
                    DoktorIme=doktorIme,
                    Email=email,
                    DatumVrijeme=entity.Od
                    
                };
                _messageProducer.SendingObject(reservation);
            }

            using var bus = RabbitHutch.CreateBus("host=localhost");
                  
            bus.PubSub.Publish(entity);               
            
            return entity;
        }

    }
}
