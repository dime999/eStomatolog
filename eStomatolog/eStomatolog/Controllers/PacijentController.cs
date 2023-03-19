using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PacijentController : Controller
    {

        private readonly IService<eStomatologModel.Pacijent> _service;

        public PacijentController(IService<eStomatologModel.Pacijent> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Pacijent> Get() {

          return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Pacijent GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
