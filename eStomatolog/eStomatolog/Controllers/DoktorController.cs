using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DoktorController : Controller
    {
        private readonly IService<eStomatologModel.Doktor, object> _service;

        public DoktorController(IService<eStomatologModel.Doktor, object> service)
        {
            this._service = service;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Doktor> Get()
        {
            return _service.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Doktor GetById(int id)
        {
            return _service.GetById(id);
        }
    }
}
