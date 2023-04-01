using AutoMapper;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {
        public eStomatologContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseService(eStomatologContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }
        public virtual IEnumerable<T> Get(TSearch search = null)
        {
            var entity = Context.Set<TDb>().AsQueryable();

            entity = AddFilter(entity, search);

            if(search?.Page.HasValue==true && search?.Size.HasValue==true)
            {
                entity = entity.Take(search.Size.Value).Skip(search.Page.Value * search.Size.Value);
            }

            var list = entity.ToList();
            //NOTE: elaborate IEnumerable vs IList
            return Mapper.Map<IList<T>>(list);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch search = null)
        {
            return query;
        }

        public T GetById(int id)
        {
            var set = Context.Set<TDb>();

            var entity = set.Find(id);

            return Mapper.Map<T>(entity);
        }
    }
}
