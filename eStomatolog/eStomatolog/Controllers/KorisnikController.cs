using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class KorisnikController : BaseController<eStomatologModel.Korisnik, KorisnikSearchObject>
    {
        public KorisnikController(IKorisniciService service)
            : base(service)
        {
        }
    }
}
