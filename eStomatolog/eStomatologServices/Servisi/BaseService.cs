using AutoMapper;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class BaseService<T, TDb> : IService<T> where T : class where TDb : class
    {
        public eStomatologContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseService(eStomatologContext context,IMapper mapper) 
        {
            Context = context;
            Mapper = mapper;    
        
        }

        IEnumerable<T> IService<T>.Get()
        {
            var entity = Context.Set<TDb>();
            var list = entity.ToList();
            return Mapper.Map<IList<T>>(list);

        }

        T IService<T>.GetById(int id)
        {
            var set = Context.Set<TDb>();

            var entity = set.Find(id);

            return Mapper.Map<T>(entity);
        }
    }
}
