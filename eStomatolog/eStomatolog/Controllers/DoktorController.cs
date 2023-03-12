using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DoktorController : Controller
    {
        private readonly IDoktorService DoktorService;

        public DoktorController(IDoktorService doktorService)
        {
            this.DoktorService = doktorService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Doktor> Get()
        {
            return DoktorService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Doktor GetById(int id)
        {
            return DoktorService.GetById(id);
        }
    }
}
