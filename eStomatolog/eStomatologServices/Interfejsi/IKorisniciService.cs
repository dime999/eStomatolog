using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IKorisniciService : ICRUDService<eStomatologModel.Korisnik, KorisnikSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        Task<eStomatologModel.Korisnik> Login(string username, string password);
    }

}
