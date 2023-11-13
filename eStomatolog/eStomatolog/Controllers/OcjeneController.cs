using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
 

    public class OcjeneController : BaseCRUDController<eStomatologModel.Ocjene, BaseSearchObject, OcjenaUpsertRequest, OcjenaUpsertRequest>
    {
        private readonly IOcjenaService _service;
        public OcjeneController(IOcjenaService service)
            : base(service)
        {
            this._service = service;
        }

        [HttpGet("/GetOcjeneByDoktorId/{id}")]
        public IEnumerable<eStomatologModel.Ocjene> GetOcjeneByDoktorId(int id)
        {
            var ocjene = _service.GetByDoktorId(id);

            return ocjene;
        }


    }
}
