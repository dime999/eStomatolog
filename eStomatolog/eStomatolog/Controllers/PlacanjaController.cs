using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class PlacanjaController : Controller
    {

        private readonly IPlacanjaService PlacanjaService;

        public PlacanjaController(IPlacanjaService placanjaService)
        {
            this.PlacanjaService = placanjaService;
        }


        [HttpGet]
        public IEnumerable<eStomatologModel.Placanja> Get() {

          return PlacanjaService.Get();
        }

        [HttpGet("{id}")]
        public eStomatologModel.Placanja GetById(int id)
        {
            return PlacanjaService.GetById(id);
        }
    }
}
