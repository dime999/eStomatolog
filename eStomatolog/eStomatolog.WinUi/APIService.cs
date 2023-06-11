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

        public async Task<T> Login<T>(string username, string pass)
        {
            var url = $"{_endpoint}{_resource}?Username={username}&Password={pass}";

            var result = await url.WithBasicAuth(username, pass).GetJsonAsync<T>();
            return result;
        }

        public async Task<T> GetByKorisnikId<T>(int id)
        {
            var url = $"{_endpoint}{_resource}/{id}";

            var result = await url.WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return result;
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


        public async Task<T> GetByDoktorId<T>(int id)
        {
            var list = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return list;
        }

        public async Task<T> GetOrdinacijaSlikeIds<T>(int ordinacijaId)
        {
            var list = await $"{_endpoint}{_resource}/?ordinacijaId={ordinacijaId}".WithBasicAuth(Username,Password).GetJsonAsync<T>();
            return list;
        }

        public async Task<byte[]> GetSlikaStream<T>(int imageId)
        {
            var url = ($"{_endpoint}{_resource}?slikaId={imageId}");
            var resultPath = await url.WithBasicAuth(Username, Password).DownloadFileAsync(Application.StartupPath, "index.jpg");

            return File.ReadAllBytes(resultPath);
        }

        public async Task<T> IzbrisiSliku<T>(int id)
        {
          
            var list = await $"{_endpoint}{_resource}/?id={id}".WithBasicAuth(Username, Password).DeleteAsync().ReceiveJson<T>();
            return list;
        }




    }
}
