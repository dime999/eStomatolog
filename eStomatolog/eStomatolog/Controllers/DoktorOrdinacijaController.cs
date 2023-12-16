using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
   


    public class DoktorOrdinacijaController : BaseCRUDController<eStomatologModel.DoktorOrdinacija, BaseSearchObject, DoktorOrdinacijaInsertRequest, DoktorOrdinacijaInsertRequest>
    {
        public IDoktoriOrdinacije service { get; set; }
        public DoktorOrdinacijaController(IDoktoriOrdinacije service)
            : base(service)
        {
            this.service = service;
        }



        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetByDoktorId/{id}")]
        public async Task<IEnumerable<DoktorOrdinacija>> GetByDoktorId(int id)
        {
            var list = service.GetByDoktorId(id);

            return list.ToList();
        }



        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpGet("/GetByOrdinacijaId/{id}")]
        public async Task<IEnumerable<DoktorOrdinacijaDoktorInfo>> GetDoktori(int id)
        {
            var list = service.GetByOrdinacijaId(id);

            return list.ToList();
        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpGet("/GetByOrdinacijaInfo/{id}")]
        public async Task<IEnumerable<DoktorOrdinacijaOrdinacijaInfo>> GetOrdinacije(int id)
        {
            var list = service.GetOrdinacijaInfo(id);

            return list.ToList();
        }
    }
}
