
using eStomatologModel.SearchObjects;
using eStomatologServices;
using eStomatologServices.Interfejsi;
using eStomatologServices.Servisi;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddTransient<IService<eStomatologModel.Pacijent,KorisnikSearchObject>,PacijentService>();

builder.Services.AddTransient<IService<eStomatologModel.Korisnik,KorisnikSearchObject>,KorisniciService>();
builder.Services.AddTransient<IService<eStomatologModel.Dijagnoza, object>,DijagnozaService>();
builder.Services.AddTransient<IService<eStomatologModel.Doktor, object>,DoktorService>();
builder.Services.AddTransient<IService<eStomatologModel.Placanja, object>,PlacanjaService>();
builder.Services.AddTransient<IService<eStomatologModel.Termin, object>,TerminService>();
builder.Services.AddTransient<IService<eStomatologModel.Usluga, object>,UslugaService>();
builder.Services.AddTransient<IService<eStomatologModel.Recept, object>,ReceptService>();


builder.Services.AddAutoMapper(typeof(IKorisniciService));


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<eStomatologContext>(options => options.UseSqlServer(connectionString));


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
