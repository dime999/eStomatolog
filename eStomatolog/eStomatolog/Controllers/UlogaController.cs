using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class UlogaController : BaseController<eStomatologModel.Uloge, BaseSearchObject>
    {
        public UlogaController(IService<Uloge, BaseSearchObject> service)
            : base(service)
        {
        }
    }
}
