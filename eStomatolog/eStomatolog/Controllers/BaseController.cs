﻿using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        public IService<T, TSearch> Service { get; set; }

        public BaseController(IService<T, TSearch> service)
        {
            Service = service;
        }

        [AllowAnonymous]
        [HttpGet]
        public virtual IEnumerable<T> Get([FromQuery] TSearch search = null)
        {
            return Service.Get(search);
        }

        [AllowAnonymous]
        [HttpGet("{id}")]
        public virtual T GetById(int id)
        {
            return Service.GetById(id);
        }
    }


}
