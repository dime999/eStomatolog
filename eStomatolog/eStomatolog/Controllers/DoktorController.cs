using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
    public class DoktorController : BaseCRUDController<eStomatologModel.Doktor, BaseSearchObject, DoktorUpsertRequest, DoktorUpsertRequest>
    {
        public IDoktorService service { get; set; }
        public DoktorController(IDoktorService service)
            : base(service)
        {
            this.service = service;
        }

        [AllowAnonymous]
        [HttpGet("/GetByKorisnikId/{id}")]
        public async Task<eStomatologModel.Doktor> GetByKorisnikId(int id)
        {
            var doktor = service.GetByKorisnikId(id);

            return doktor;
        }


        [AllowAnonymous]
        [HttpGet("/GetRecommended/{id}")]
        public async Task<IEnumerable<Doktor>> GetDoktori(int id)
        {
            var list = service.Recommended(id);

            return list.ToList();
        }


      

    }



}
