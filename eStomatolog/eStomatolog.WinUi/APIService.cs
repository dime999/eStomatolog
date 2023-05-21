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

        public static string Username = null;
        public static string Password = null;

        public APIService(string resource)
        {
            this._resource = resource;
        }

        public async Task<T> Get<T>(object search = null)
        {
            var list = await $"{_endpoint}{_resource}".GetJsonAsync<T>();
            return list;
        }

        public async Task<T> GetById<T>(int id)
        {
            var list = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return list;
        }

        public async Task<T> Post<T>(object request)
        {
            var list = await $"{_endpoint}{_resource}".WithBasicAuth(Username,Password).PostJsonAsync(request).ReceiveJson<T>();
            return list;
        }

        public async Task<T> Register<T>(object request)
        {
            var list = await $"{_endpoint}{_resource}".PostJsonAsync(request).ReceiveJson<T>();
            return list;
        }

        public async Task<T> Put<T>(int id,object request)
        {
            var list = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<T>();
            return list;
        }

    }
}
