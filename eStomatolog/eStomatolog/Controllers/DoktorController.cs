using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DoktorController : Controller
    {
        private readonly IService<eStomatologModel.Doktor, BaseSearchObject> _service;

        public DoktorController(IService<eStomatologModel.Doktor, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Doktor> Get([FromQuery] BaseSearchObject? search = null)
        {
            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Doktor GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
