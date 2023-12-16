using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eStomatolog.Controllers
{
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class where TInsert : class where TUpdate : class 
    {
        public BaseCRUDController(ICRUDService<T,TSearch,TInsert,TUpdate> service) : base(service) 
        {

        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpPost]
        public virtual T Insert([FromBody]TInsert insert)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Insert(insert);
            return result;
        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpPut("{id}")]
        public virtual T Update(int id,[FromBody]TUpdate update)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Update(id,update);
            return result;
        }

        [Authorize(Roles = "Administrator, Korisnik")]
        [HttpDelete]
        public  virtual T Delete(int id)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Delete(id);
            return result;
        }
    }
}
