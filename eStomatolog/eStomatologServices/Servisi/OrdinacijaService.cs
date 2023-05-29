using AutoMapper;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eStomatologServices.Servisi
{
    public class OrdinacijaService : BaseCRUDService<eStomatologModel.Ordinacija, Database.Ordinacija, BaseSearchObject, OrdinacijaUpsertRequest, OrdinacijaUpsertRequest>, IOrdinacijaService
    {
        public OrdinacijaService(eStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        //public override eStomatologModel.Ordinacija Insert(OrdinacijaUpsertRequest insert)
        //{
        //    insert.Slika = GetDefaultImageBytes();
        //    var entity = base.Insert(insert);
        //    Context.SaveChanges();
        //    return entity;
        //}
        //private bool IsImagePathValid(string imagePath)
        //{
        //    return File.Exists(imagePath);
        //}
        //private byte[] GetDefaultImageBytes(string imagePath = "C:\\Code\\FIT-RS2-2023\\eStomatolog\\eStomatologServices\\Slike\\ordinacijaa.jpg")
        //{
        //    // Učitavanje slike iz fajla na osnovu putanje
        //    byte[] imageBytes;
        //    bool isPathValid = IsImagePathValid(imagePath);
        //    using (FileStream fileStream = new FileStream(imagePath, FileMode.Open, FileAccess.Read))
        //    {
        //        using (MemoryStream memoryStream = new MemoryStream())
        //        {
        //            fileStream.CopyTo(memoryStream);
        //            imageBytes = memoryStream.ToArray();
        //        }
        //    }
        //    return imageBytes;
        //}

        
    }
}
