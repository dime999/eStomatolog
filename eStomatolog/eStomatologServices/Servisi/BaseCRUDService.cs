﻿using AutoMapper;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate> where T : class where TDb : class  where TInsert : class where TUpdate : class where TSearch : BaseSearchObject
    {

        public eStomatologContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseCRUDService(eStomatologContext context, IMapper mapper)
            :base(context,mapper) { 

            this.Context = context;
            this.Mapper = mapper;
        }

        public virtual T Insert(TInsert insert)
        {
            var set = Context.Set<TDb>();
            TDb entity = Mapper.Map<TDb>(insert);
            set.Add(entity);
            BeforeInsert(insert, entity);
            Context.SaveChanges();
            return Mapper.Map<T>(entity);
        }

        public virtual T Update(int id, TUpdate update)
        {
            var set = Context.Set<TDb>();
            var entity = set.Find(id);
            if(entity != null)
            {
                    Mapper.Map(update, entity);
            }
            else
            {
                return null;
            }
            Context.SaveChanges();
            return Mapper.Map<T>(entity);
        }

        public virtual void BeforeInsert(TInsert insert, TDb entity)
        {

        }

        public  virtual T Delete(int id)
        {
            var set = Context.Set<TDb>();

            var entity =  set.Find(id);

            set.Remove(entity);

            Context.SaveChanges();

            return Mapper.Map<T>(entity);
        }
    }
}
