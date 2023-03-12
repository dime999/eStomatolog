using eStomatologModel;
using eStomatologServices.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface IKorisniciService
    {
        IEnumerable<eStomatologModel.Korisnik> Get();
        eStomatologModel.Korisnik GetById(int id);
    }

}
