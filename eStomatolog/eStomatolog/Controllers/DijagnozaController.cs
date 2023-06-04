using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
    
    public class DijagnozaController : BaseCRUDController<eStomatologModel.Dijagnoza, BaseSearchObject, DijanozaInsertRequest, DijagnozaUpdateRequest>
    {
        public IDijagnozaService service { get; set; }
        public DijagnozaController(IDijagnozaService service)
            : base(service)
        {
            this.service = service;
        }


        [Authorize(Roles = "Administrator")]
        [HttpGet("/GetByPacijent/{id}")]
        public async Task<IEnumerable<DijagnozaInfoModel>> GetByPacijent(int id)
        {
            var list = service.GetByPacijentId(id);

            return list.ToList();
        }
    }
}
