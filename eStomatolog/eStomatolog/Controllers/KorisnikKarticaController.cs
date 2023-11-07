using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
  
    public class KorisnikKarticaController : BaseCRUDController<eStomatologModel.KorisnikKartica, BaseSearchObject, KorisnikKarticaUpsertRequest, KorisnikKarticaUpsertRequest>
    {
        public IKorisnikKartica _service { get; set; }
        public KorisnikKarticaController(IKorisnikKartica service)
            : base(service)
        {
            this._service = service;
        }

        [HttpGet("/GetKartice/{id}")]
        public async Task<IEnumerable<KorisnikKartica>> GetByKorinikId(int id)
        {
            var list = _service.GetByKorisnikId(id);

            return list.ToList();
        }
    }
}
