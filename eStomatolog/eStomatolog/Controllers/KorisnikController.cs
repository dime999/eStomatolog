﻿using eStomatologModel.Requests;
using eStomatologModel;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using eStomatologServices.Models;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class KorisnikController : BaseCRUDController<eStomatologModel.Korisnik, KorisnikSearchObject,KorisniciInsertRequest,KorisniciUpdateRequest>
    {
        public KorisnikController(IKorisniciService service)
            : base(service)
        {
        }
        //[Authorize("Administrator")]
        public override eStomatologModel.Korisnik Insert([FromBody] KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }

        //[Authorize("Administrator")]
        public override eStomatologModel.Korisnik Update(int id, [FromBody] KorisniciUpdateRequest update)
        {
            return base.Update(id, update);
        }
    }
}
