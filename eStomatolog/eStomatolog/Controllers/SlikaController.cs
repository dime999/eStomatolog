using eStomatologModel;
using eStomatologModel.Requests;
using eStomatologModel.SearchObjects;
using eStomatologServices.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.VisualStudio.Services.Notifications.VssNotificationEvent;

namespace eStomatolog.Controllers
{
   
    public class SlikaController : BaseCRUDController<eStomatologModel.Slika, BaseSearchObject, SlikaInsertRequest, SlikaUpdateRequest>
    {
        public ISlikaService service { get; set; }
        public SlikaController(ISlikaService service)
            : base(service)
        {
            this.service = service;
        }

        [AllowAnonymous]
        [HttpGet("/SlikaStream")]
        public async Task<FileContentResult> GetSlikaStream([FromQuery] int slikaId)
        {
            var imageBytes = await service.GetPictureStream(slikaId);
            return File(imageBytes, "image/jpeg");
        }

        [AllowAnonymous]
        [HttpGet("/OrdinacijaSlikeIds")]
        public async Task<Galerija> GetOrdinacijaSlika([FromQuery] int ordinacijaId)
        {
            var galerija = await service.GetOrdinacijeSlikeIds(ordinacijaId);
            return galerija;
        }

        [AllowAnonymous]
        [HttpPost("/InsertOrdinacijaSlika")]
        public async Task<eStomatologModel.Slika> InsertOrdinacijaSlika([FromForm] SlikaInsertRequest request)
        {
            var form = Request.Form;
            request.SlikaFile = form.Files[0];
            return await service.InsertOrdinacijaSlika(request);
        }

        [AllowAnonymous]
        [HttpGet("/DoktorSlikaIds")]
        public async Task<Galerija> GetDoktorSlika([FromQuery] int doktorId)
        {
            var galerija = await service.GetDoktorSlikeIds(doktorId);
            return galerija;
        }

        [AllowAnonymous]
        [HttpPost("/InsertDoktorSlika")]
        public async Task<eStomatologModel.Slika> InsertDoktorSlika([FromForm] DoktorSlikaInsertRequest request)
        {
            var form = Request.Form;
            request.SlikaFile = form.Files[0];
            return await service.InsertDoktorSlika(request);
        }

    }
}
