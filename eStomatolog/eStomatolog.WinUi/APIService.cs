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
            var list = await $"{_endpoint}{_resource}".WithBasicAuth(Username,Password).GetJsonAsync<T>();
            return list;
        }

        public async Task<T> GetById<T>(int id)
        {
            var list = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Username, Password).GetJsonAsync<T>();
            return list;
        }

        public async Task<T> Post<T>(object request)
        {
            var list = await $"{_endpoint}{_resource}".WithBasicAuth(Username, Password).PostJsonAsync(request).ReceiveJson<T>();
            return list;
        }

        public async Task<T> Put<T>(int id,object request)
        {
            var list = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<T>();
            return list;
        }

        public async Task<T> Register<T>(object request)
        {
            try
            {         
                    var url = $"{_endpoint}/{_resource}";
                    var result = await url.WithHeader("Authorization", "Basic")
                        .PostJsonAsync(request).ReceiveJson<T>();
                    return result;             
            }
            catch (FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string[]>>();

                var stringBuilder = new StringBuilder();
                foreach (var error in errors)
                {
                    stringBuilder.AppendLine($"{error.Key}, ${string.Join(",", error.Value)}");
                }

                MessageBox.Show(stringBuilder.ToString(), "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(T);
            }
        }


    }
}
