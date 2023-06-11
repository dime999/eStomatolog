using AutoMapper;
using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Users;

namespace eStomatologServices.Servisi
{
    public class SlikaService : BaseCRUDService<eStomatologModel.Slika, Database.Slika, BaseSearchObject, SlikaInsertRequest, SlikaUpdateRequest>, ISlikaService
    {
        private IWebHostEnvironment _hostEnvironment;
        private eStomatologContext _context;

        public SlikaService(eStomatologContext context, IMapper mapper, IWebHostEnvironment hostEnvironment)
            : base (context,mapper)
        {
            _context = context;
            _hostEnvironment = hostEnvironment;
        }

        public async Task<byte[]> GetPictureStream(int slikaId)
        {
            Byte[] imageBytes;
            try
            {
                string slikaIme = Path.GetFileName(Context.Slike.Find(slikaId).Path);
                string imagePath = "/images/" + slikaIme;
                var path = _hostEnvironment.ContentRootPath + imagePath;
                imageBytes = await File.ReadAllBytesAsync(path);

                return imageBytes;
            }
            catch (Exception ex)
            {
                throw new UserException("Greska kod prikazivanja slika" + ex.Message);
            }
        }    

        public async Task<Galerija> GetOrdinacijeSlikeIds(int ordinacijaId)
        {
            var galerija = new Galerija();

            galerija.Rows = await Context.OrdinacijaSlike.Where(x => x.OrdinacijaId == ordinacijaId).Select(x => new Galerija.Row { slikaId = x.SlikaId }).ToListAsync();
            galerija.slikeIds = new int[galerija.Rows.Count()];
            for (int i = 0; i < galerija.Rows.Count(); i++)
            {
                galerija.slikeIds[i] = galerija.Rows.ElementAt(i).slikaId;
            }
            return galerija;
        }


        public async Task<eStomatologModel.Slika> InsertOrdinacijaSlika(SlikaInsertRequest request)
        {
            var imagePath = await UploadFile(request.SlikaFile);

            var entry = _context.Slike.Add(new Database.Slika()
            {
                Path = imagePath
            });

            _context.SaveChanges();

            var slikaId = _context.Slike.OrderByDescending(x => x.SlikaId).First().SlikaId;
            var ordinacijaSlika = _context.OrdinacijaSlike.Add(new Database.OrdinacijaSlika()
            {
                OrdinacijaId = (int)request.OrdinacijaId,
                SlikaId = slikaId
            });

            _context.SaveChanges();

            return Mapper.Map<eStomatologModel.Slika>(entry.Entity);
        }

        public async Task<string> UploadFile(IFormFile file)
        {
            string imageName = new String(Path.GetFileNameWithoutExtension(file.FileName).Take(10).ToArray()).Replace(' ', '-');
            imageName = imageName + DateTime.Now.ToString("yymmssfff") + Path.GetExtension(file.FileName);
            string path = Path.Combine(_hostEnvironment.ContentRootPath + "/images/" + imageName);
            using (var stream = new FileStream(path, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            return path;
        }


    }
}
