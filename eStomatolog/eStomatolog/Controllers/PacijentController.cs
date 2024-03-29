﻿using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{

    public class PacijentController : BaseCRUDController<eStomatologModel.Pacijent, PacijentSearchObject,PacijentUpdateRequest,PacijentUpdateRequest>
    {
        public IPacijentService service { get; set; }
        public PacijentController(IPacijentService service)
            : base(service)
        {
            this.service = service;
        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpGet("/GetPacijentByKorisnikId/{id}")]
        public async Task<eStomatologModel.Pacijent> GetByKorisnikId(int id)
        {
            var pacijent = service.GetByKorisnikId(id);

            return pacijent;
        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpGet("/GetSlicni")]
        public async Task<eStomatologModel.Pacijent> GetSlicni(int id)
        {
            var pacijent = service.PronadiNajblizegPacijenta(id);

            return pacijent;
        }
    }
}
