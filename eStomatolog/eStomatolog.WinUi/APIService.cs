using Flurl.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatolog.WinUi
{
    public class APIService
    {
        private string _resource = null;
        public string _endpoint = "https://localhost:7265/";

        public APIService(string resource)
        {
            this._resource = resource;
        }

        public async Task<T> Get<T>()
        {
            var list = await $"{_endpoint}{_resource}".GetJsonAsync<T>();
            return list;
        }

        public async Task<T> GetById<T>(int id)
        {
            var list = await $"{_endpoint}{_resource}/{id}".GetJsonAsync<T>();
            return list;
        }
    }
}
