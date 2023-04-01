using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class ReceptController : BaseController<eStomatologModel.Recept, BaseSearchObject>
    {
        public ReceptController(IReceptService service)
            : base(service)
        {
        }
    }
}
