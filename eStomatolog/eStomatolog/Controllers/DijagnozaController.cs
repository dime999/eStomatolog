using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DijagnozaController : Controller
    {
        private readonly IService<eStomatologModel.Dijagnoza, BaseSearchObject> _service;

        public DijagnozaController(IService<eStomatologModel.Dijagnoza, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Dijagnoza> Get([FromQuery] BaseSearchObject? search = null)
        {
            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Dijagnoza GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
