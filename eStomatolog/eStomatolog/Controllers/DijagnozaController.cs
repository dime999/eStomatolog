using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    
    public class DijagnozaController : BaseCRUDController<eStomatologModel.Dijagnoza, BaseSearchObject, DijanozaInsertRequest, DijagnozaUpdateRequest>
    {
        public DijagnozaController(IDijagnozaService service)
            : base(service)
        {
        }
    }
}
