using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class UslugaController : Controller
    {

        private readonly IUslugaService UslugaService;

        public UslugaController(IUslugaService uslugaService)
        {
            this.UslugaService = uslugaService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Usluga> Get() {

          return UslugaService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Usluga GetById(int id)
        {
            return UslugaService.GetById(id);
        }
    }
}
