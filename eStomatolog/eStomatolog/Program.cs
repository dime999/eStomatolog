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

builder.Services.AddTransient<IService<eStomatologModel.Pacijent>,PacijentService>();
builder.Services.AddTransient<IService<eStomatologModel.Korisnik>,KorisniciService>();
builder.Services.AddTransient<IService<eStomatologModel.Dijagnoza>,DijagnozaService>();
builder.Services.AddTransient<IService<eStomatologModel.Doktor>,DoktorService>();
builder.Services.AddTransient<IService<eStomatologModel.Placanja>,PlacanjaService>();
builder.Services.AddTransient<IService<eStomatologModel.Termin>,TerminService>();
builder.Services.AddTransient<IService<eStomatologModel.Usluga>,UslugaService>();
builder.Services.AddTransient<IService<eStomatologModel.Recept>,ReceptService>();


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
