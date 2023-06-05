using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Interfejsi
{
    public interface ISlikaService : ICRUDService<eStomatologModel.Slika, BaseSearchObject, SlikaInsertRequest,SlikaUpdateRequest>
    {
        Task<Byte[]> GetPictureStream(int slikaId);
        Task<Galerija> GetOrdinacijeSlikeIds(int ordinacijaId);
        Task<eStomatologModel.Slika> InsertOrdinacijaSlika(SlikaInsertRequest request);
    }
}
