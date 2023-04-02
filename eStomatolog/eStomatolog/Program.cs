
using eStomatologModel.SearchObjects;
using eStomatologServices;
using eStomatologServices.Interfejsi;
using eStomatologServices.Servisi;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddTransient<IPacijentService, PacijentService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IDijagnozaService, DijagnozaService>();
builder.Services.AddTransient<IDoktorService, DoktorService>();
builder.Services.AddTransient<IPlacanjaService, PlacanjaService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<IReceptService, ReceptService>();
builder.Services.AddTransient<IVrstaUslugeService, VrstaUslugeService>();


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
