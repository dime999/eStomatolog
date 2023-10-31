using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologModel;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
   

    public class DoktorSpecijalizacijaController : BaseCRUDController<eStomatologModel.DoktoriSpecijalizacije, BaseSearchObject, DoktoriSpecijalizacijeUpsertRequest, DoktoriSpecijalizacijeUpsertRequest>
    {
        public IDoktorSpecijalizacijeService service { get; set; }
        public DoktorSpecijalizacijaController(IDoktorSpecijalizacijeService service)
            : base(service)
        {
            this.service = service;
        }


        [HttpGet("/GetSpecijalizacijeByDoktorId/{id}")]
        public async Task<IEnumerable<DoktoriSpecijalizacije>> GetByDoktorId(int id)
        {
            var list = service.GetByDoktorId(id);

            return list.ToList();
        }

    }
}
