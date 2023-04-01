using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class TerminController : Controller
    {

        private readonly IService<eStomatologModel.Termin, BaseSearchObject> _service;

        public TerminController(IService<eStomatologModel.Termin, BaseSearchObject> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Termin> Get([FromQuery] BaseSearchObject? search = null)
        {

            return _service.Get(search);
        }

        [HttpGet("{id}")]
        public eStomatologModel.Termin GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
