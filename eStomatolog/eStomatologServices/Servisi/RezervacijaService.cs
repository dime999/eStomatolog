using AutoMapper;
using EasyNetQ;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.EntityFrameworkCore;
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
        public RezervacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
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

            //var factory = new ConnectionFactory { HostName = "localhost", Port = 15672, UserName = "test", Password = "test123" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();

            //channel.QueueDeclare(queue: "reservation_added",
            //                     durable: false,
            //                     exclusive: false,
            //                     autoDelete: false,
            //                     arguments: null);

            //const string message = "Reservation added!";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "reservation_added",
            //                     basicProperties: null,
            //                     body: body);

            using var bus = RabbitHutch.CreateBus("host=localhost");
                  
            bus.PubSub.Publish(entity);               
            
            return entity;
        }

    }
}
