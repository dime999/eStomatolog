using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class TerminController : Controller
    {

        private readonly IService<eStomatologModel.Termin, object> _service;

        public TerminController(IService<eStomatologModel.Termin, object> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Termin> Get() {

          return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Termin GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
