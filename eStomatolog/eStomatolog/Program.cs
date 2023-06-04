
using eStomatolog;
using eStomatologModel.SearchObjects;
using eStomatologServices;
using eStomatologServices.Database;
using eStomatologServices.Interfejsi;
using eStomatologServices.Servisi;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c=>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme,Id="basicAuth"
            }
        },
            new string []{}
    }});
});

builder.Services.AddTransient<IPacijentService, PacijentService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IDijagnozaService, DijagnozaService>();
builder.Services.AddTransient<IDoktorService, DoktorService>();
builder.Services.AddTransient<IPlacanjaService, PlacanjaService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<IReceptService, ReceptService>();
builder.Services.AddTransient<IVrstaUslugeService, VrstaUslugeService>();
builder.Services.AddTransient<IOrdinacijaService, OrdinacijaService>();
builder.Services.AddTransient<ISpecijalizacijaService, SpecijalizacijaService>();
builder.Services.AddTransient<IGradService, GradService>();
builder.Services.AddTransient<IDoktoriOrdinacije, DoktoriOrdinacijeService>();
builder.Services.AddTransient<IOrdinacijaService, OrdinacijaService>();



builder.Services.AddTransient<IService<eStomatologModel.Uloge, BaseSearchObject>, BaseService<eStomatologModel.Uloge, Uloge, BaseSearchObject>>();

builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication",null);



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

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
