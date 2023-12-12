using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class initial_seed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.CreateTable(
                name: "Gradovi",
                columns: table => new
                {
                    GradId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gradovi", x => x.GradId);
                });

            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false, defaultValueSql: "((1))")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikID);
                });



            migrationBuilder.CreateTable(
                name: "Slike",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Path = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Slike", x => x.SlikaId);
                });

            migrationBuilder.CreateTable(
                name: "Specijalizacije",
                columns: table => new
                {
                    SpecijalizacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Specijalizacije", x => x.SpecijalizacijaId);
                });

            migrationBuilder.CreateTable(
                name: "Termini",
                columns: table => new
                {
                    TerminId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Vrijeme = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Termini", x => x.TerminId);
                });

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    UlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloge", x => x.UlogaID);
                });

            migrationBuilder.CreateTable(
                name: "Usluge",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(10,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Usluge__3214EC07FCE82835", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "VrstaUsluge",
                columns: table => new
                {
                    VrstaUslugeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrstaUsluge", x => x.VrstaUslugeId);
                });

            migrationBuilder.CreateTable(
                name: "Ordinacije",
                columns: table => new
                {
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ordinacije", x => x.OrdinacijaId);
                    table.ForeignKey(
                        name: "FK_Ordinacije_Gradovi_GradId",
                        column: x => x.GradId,
                        principalTable: "Gradovi",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Doktori",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Doktori__3214EC07B54830FE", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Doktori_Gradovi_GradId",
                        column: x => x.GradId,
                        principalTable: "Gradovi",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Doktori_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisnikKartice",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    BrojKartice = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    VrstaKartica = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumIsteka = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cvv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikKartica", x => x.Id);
                    table.ForeignKey(
                        name: "FK_KorisnikKartice_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Pacijenti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Pacijenti__3214EC07B54830TE", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Pacijenti_Gradovi_GradId",
                        column: x => x.GradId,
                        principalTable: "Gradovi",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Pacijenti_Korisnik_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloge",
                columns: table => new
                {
                    KorisnikUlogaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    UlogaID = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloge", x => x.KorisnikUlogaID);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Korisnici",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikID");
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Uloge",
                        column: x => x.UlogaID,
                        principalTable: "Uloge",
                        principalColumn: "UlogaID");
                });

            migrationBuilder.CreateTable(
                name: "Usluga",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    VrstaUslugeId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usluga", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Usluga_VrstaUsluge_VrstaUslugeId",
                        column: x => x.VrstaUslugeId,
                        principalTable: "VrstaUsluge",
                        principalColumn: "VrstaUslugeId");
                });

            migrationBuilder.CreateTable(
                name: "OrdinacijaSlike",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ordinacija_slika", x => new { x.OrdinacijaId, x.SlikaId });
                    table.ForeignKey(
                        name: "FK_OrdinacijaSlike_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrdinacijaSlike_Slike_SlikaId",
                        column: x => x.SlikaId,
                        principalTable: "Slike",
                        principalColumn: "SlikaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DoktoriOrdinacije",
                columns: table => new
                {
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoktoriOrdinacije", x => new { x.DoktorId, x.OrdinacijaId });
                    table.ForeignKey(
                        name: "FK_DoktoriOrdinacije_Doktori_DoktorId",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DoktoriOrdinacije_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DoktoriSpecijalizacije",
                columns: table => new
                {
                    DoktorSpecijalizacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    SpecijalizacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoktoriSpecijalizacije", x => x.DoktorSpecijalizacijaId);
                    table.ForeignKey(
                        name: "FK_DoktoriSpecijalizacije_Doktori_DoktorId",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DoktoriSpecijalizacije_Specijalizacije_SpecijalizacijaId",
                        column: x => x.SpecijalizacijaId,
                        principalTable: "Specijalizacije",
                        principalColumn: "SpecijalizacijaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "DoktorSlike",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_doktor_slika", x => new { x.DoktorId, x.SlikaId });
                    table.ForeignKey(
                        name: "FK_DoktorSlike_Doktori_DoktorId",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_DoktorSlike_Slike_SlikaId",
                        column: x => x.SlikaId,
                        principalTable: "Slike",
                        principalColumn: "SlikaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
               name: "Dijagnoze",
               columns: table => new
               {
                   Id = table.Column<int>(type: "int", nullable: false)
                       .Annotation("SqlServer:Identity", "1, 1"),
                   PacijentID = table.Column<int>(type: "int", nullable: false),
                   DoktorID = table.Column<int>(type: "int", nullable: false),
                   Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                   Opis = table.Column<string>(type: "nvarchar(MAX)", maxLength: 200, nullable: true)
               },
               constraints: table =>
               {
                   table.PrimaryKey("PK__Dijagnoz__3214EC07B6723559", x => x.Id);
                   table.ForeignKey(
                       name: "FK_Dijagnoze_Doktori_DoktorID",
                       column: x => x.DoktorID,
                       principalTable: "Doktori",
                       principalColumn: "Id",
                       onDelete: ReferentialAction.Cascade);
                   table.ForeignKey(
                       name: "FK_Dijagnoze_Pacijenti_PacijentID",
                       column: x => x.PacijentID,
                       principalTable: "Pacijenti",
                       principalColumn: "Id",
                       onDelete: ReferentialAction.NoAction);
               });

            migrationBuilder.CreateTable(
                name: "Ocjene",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Ocjena = table.Column<int>(type: "int", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjene", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Ocjene_Doktori_DoktorId",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Ocjene_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "PacijentiOrdinacije",
                columns: table => new
                {
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PacijentiOrdinacije", x => new { x.PacijentId, x.OrdinacijaId });
                    table.ForeignKey(
                        name: "FK_PacijentiOrdinacije_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PacijentiOrdinacije_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "PoklonBoni",
                columns: table => new
                {
                    PoklonBonId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kod = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IznosPlacanja = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false),
                    ImePrezimeKorisnikaKojiKoristi = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false),
                    BrojKartice = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumIstekaKartice = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CvcCvvKod = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Iskoristeno = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PoklonBon", x => x.PoklonBonId);
                    table.ForeignKey(
                        name: "FK_PoklonBoni_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PoklonBoni_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Rezervacije",
                columns: table => new
                {
                    RezervacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TerminId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezervacija", x => x.RezervacijaId);
                    table.ForeignKey(
                        name: "FK_Rezervacije_Doktori_DoktorId",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Rezervacije_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Rezervacije_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_Rezervacije_Termini_TerminId",
                        column: x => x.TerminId,
                        principalTable: "Termini",
                        principalColumn: "TerminId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Dijagnoze_DoktorID",
                table: "Dijagnoze",
                column: "DoktorID");

            migrationBuilder.CreateIndex(
                name: "IX_Dijagnoze_PacijentID",
                table: "Dijagnoze",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_GradId",
                table: "Doktori",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_KorisnikId",
                table: "Doktori",
                column: "KorisnikId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriOrdinacije_OrdinacijaId",
                table: "DoktoriOrdinacije",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriSpecijalizacije_DoktorId",
                table: "DoktoriSpecijalizacije",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriSpecijalizacije_SpecijalizacijaId",
                table: "DoktoriSpecijalizacije",
                column: "SpecijalizacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_DoktorSlike_SlikaId",
                table: "DoktorSlike",
                column: "SlikaId");

            migrationBuilder.CreateIndex(
                name: "CS_Email",
                table: "Korisnik",
                column: "Email",
                unique: true,
                filter: "[Email] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "CS_KorisnickoIme",
                table: "Korisnik",
                column: "KorisnickoIme",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikKartice_KorisnikId",
                table: "KorisnikKartice",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_KorisnikID",
                table: "KorisnikUloge",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogaID",
                table: "KorisnikUloge",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_DoktorId",
                table: "Ocjene",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_OrdinacijaSlike_SlikaId",
                table: "OrdinacijaSlike",
                column: "SlikaId");

            migrationBuilder.CreateIndex(
                name: "IX_Ordinacije_GradId",
                table: "Ordinacije",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_GradId",
                table: "Pacijenti",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_KorisnikId",
                table: "Pacijenti",
                column: "KorisnikId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_PoklonBoni_OrdinacijaId",
                table: "PoklonBoni",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_PoklonBoni_PacijentId",
                table: "PoklonBoni",
                column: "PacijentId");


            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_DoktorId",
                table: "Rezervacije",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_OrdinacijaId",
                table: "Rezervacije",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_PacijentId",
                table: "Rezervacije",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_TerminId",
                table: "Rezervacije",
                column: "TerminId");

            migrationBuilder.CreateIndex(
                name: "IX_Usluga_VrstaUslugeId",
                table: "Usluga",
                column: "VrstaUslugeId");

            migrationBuilder.InsertData(
                table: "Gradovi",
                columns: new[] { "GradId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Zenica" },
                    { 2, "Sarajevo" },
                    { 3, "Mostar" }
                });

            migrationBuilder.InsertData(
                table: "Korisnik",
                columns: new[] { "KorisnikID", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Status", "Telefon" },
                values: new object[,]
                {
                    { 1, "desktop.desktop@example.com", "Desktop", "desktop", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Desktop", true, "0622227892" },
                    { 2, "adem.halilovic@gmail.com", "Adem", "adem", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Halilovic", true, "0622227892" },
                    { 3, "kenan.cosic@gmail.com", "Kenan", "kenan", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Cosic", true, "0622527892" },
                    { 4, "mobile.mobile@example.com", "Mobile", "mobile", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Mobile", true, "0622227822" },
                    { 5, "enes.talic@gmail.com", "Enes", "enes", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Talic", true, "0627877822" },
                    { 6, "salih.buro@gmail.com", "Salih", "salih", "PQ570hFK9Bu43Qw4qZ2wLAisk4c=", "RDcOKBdT86HOJAuigS+J0A==", "Buro", true, "062765822" }
                });

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[] { 1, "Oralna hirurgija" });

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[] { 2, "Endodoncija" });

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[] { 3, "Parodontologija" });

            migrationBuilder.InsertData(
                table: "Termini",
                columns: new[] { "TerminId", "Vrijeme" },
                values: new object[,]
                {
                    { 1, new DateTime(1900, 1, 1, 8, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 2, new DateTime(1900, 1, 1, 8, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 3, new DateTime(1900, 1, 1, 9, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, new DateTime(1900, 1, 1, 9, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 5, new DateTime(1900, 1, 1, 10, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 6, new DateTime(1900, 1, 1, 10, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 7, new DateTime(1900, 1, 1, 11, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 8, new DateTime(1900, 1, 1, 11, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 9, new DateTime(1900, 1, 1, 12, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 10, new DateTime(1900, 1, 1, 12, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 11, new DateTime(1900, 1, 1, 13, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 12, new DateTime(1900, 1, 1, 13, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 13, new DateTime(1900, 1, 1, 14, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 14, new DateTime(1900, 1, 1, 14, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 15, new DateTime(1900, 1, 1, 15, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 16, new DateTime(1900, 1, 1, 15, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 17, new DateTime(1900, 1, 1, 16, 0, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "Uloge",
                columns: new[] { "UlogaID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Administrator", "Administrator" },
                    { 2, "Korisnik", "Korisnik" }
                });

            migrationBuilder.InsertData(
                table: "Doktori",
                columns: new[] { "Id", "GradId", "Ime", "KorisnikId", "Prezime" },
                values: new object[,]
                {
                    { 1, 1, "Desktop", 1, "Desktop" },
                    { 2, 2, "Adem", 2, "Halilovic" },
                    { 3, 3, "Kenan", 3, "Cosic" }
                });

            migrationBuilder.InsertData(
                table: "KorisnikUloge",
                columns: new[] { "KorisnikUlogaID", "DatumIzmjene", "KorisnikID", "UlogaID" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8897), 1, 1 },
                    { 2, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8940), 2, 1 },
                    { 3, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8948), 3, 1 },
                    { 4, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8956), 4, 2 },
                    { 5, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8964), 5, 2 },
                    { 6, new DateTime(2023, 11, 18, 23, 52, 45, 62, DateTimeKind.Local).AddTicks(8973), 6, 2 }
                });

            migrationBuilder.InsertData(
                table: "Ordinacije",
                columns: new[] { "OrdinacijaId", "Adresa", "GradId", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 1, "Crkvice 40", 1, "Ordinacija1", "0603422323" },
                    { 2, "Crkvice 41", 2, "Ordinacija2", "0603422324" },
                    { 3, "Crkvice 442", 3, "Ordinacija3", "0603422325" }
                });

            migrationBuilder.InsertData(
                table: "Pacijenti",
                columns: new[] { "Id", "DatumRodjenja", "GradId", "Ime", "KorisnikId", "Prezime", "Telefon" },
                values: new object[,]
                {
                    { 1, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, "Mobile", 4, "Mobile", "062222732" },
                    { 2, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, "Enes", 5, "Talic", "062222732" },
                    { 3, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, "Salih", 6, "Buro", "063422732" }
                });

            migrationBuilder.InsertData(
                table: "DoktoriOrdinacije",
                columns: new[] { "DoktorId", "OrdinacijaId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 1, 2 },
                    { 1, 3 },
                    { 2, 1 },
                    { 2, 2 },
                    { 2, 3 },
                    { 3, 1 },
                    { 3, 2 },
                    { 3, 3 }
                });

            migrationBuilder.InsertData(
                table: "DoktoriSpecijalizacije",
                columns: new[] { "DoktorSpecijalizacijaId", "DoktorId", "SpecijalizacijaId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 },
                    { 3, 3, 3 },

                });

            migrationBuilder.InsertData(
                table: "PacijentiOrdinacije",
                columns: new[] { "OrdinacijaId", "PacijentId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 2, 1 },
                    { 3, 1 },
                    { 1, 2 },
                    { 2, 2 },
                    { 3, 2 },
                    { 1, 3 },
                    { 2, 3 },
                    { 3, 3 }
                });


            migrationBuilder.InsertData(
              table: "Dijagnoze",
              columns: new[] { "Id", "Datum", "DoktorID", "Opis", "PacijentID" },
              values: new object[,]
              {
                    { 1, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6325), 1, "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina.", 1 },
                    { 2, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6337), 2, "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina.", 2 },
                    { 3, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6346), 3, "Pacijent je podvrgnut rutinskom stomatološkom pregledu koji obuhvatao vizuelni pregled oralne šupljine i rendgenske snimke zuba. Uočena je prisutnost karijesa na donjim kutnjacima, s preporukom za plombiranje zahvaćenih površina.", 3 }
              });



            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "Id", "Datum", "DoktorId", "Ocjena", "Opis", "PacijentId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6399), 1, 5, "Jako komunikativan doktor.", 1 },
                    { 2, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6410), 2, 5, "Najbolji doktor.", 1 },
                    { 3, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6419), 3, 5, "Jako komunikativan doktor.", 1 },
                    { 4, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6428), 1, 3, "Dobar doktor.", 2 },
                    { 5, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6437), 2, 4, "Najbolji doktor.", 2 },
                    { 6, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6447), 3, 5, "Jako komunikativan doktor.", 2 },
                    { 7, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6456), 1, 3, "Jako komunikativan doktor.", 3 },
                    { 8, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6465), 2, 4, "Najbolji doktor.", 3 },
                    { 9, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6474), 3, 5, "Jako komunikativan doktor.", 3 }
                });

            migrationBuilder.InsertData(
                table: "PoklonBoni",
                columns: new[] { "PoklonBonId", "BrojKartice", "CvcCvvKod", "DatumIstekaKartice", "ImePrezimeKorisnikaKojiKoristi", "Iskoristeno", "IznosPlacanja", "Kod", "OrdinacijaId", "PacijentId", "Placeno" },
                values: new object[,]
                {
                    { 1, "", "", new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6362), "Adem Halilovic", false, 50m, "123456", 1, 1, true },
                    { 2, "", "", new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6376), "Adem Halilovic", true, 100m, "123456", 2, 2, true },
                    { 3, "", "", new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6385), "Adem Halilovic", false, 50m, "123456", 3, 3, true }
                });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "RezervacijaId", "Datum", "DoktorId", "Email", "OrdinacijaId", "PacijentId", "TerminId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6488), 1, "", 1, 1, 2 },
                    { 2, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6542), 1, "", 1, 1, 3 },
                    { 3, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6555), 1, "", 1, 1, 4 },
                    { 4, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6565), 2, "", 2, 2, 3 },
                    { 5, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6574), 2, "", 2, 2, 4 },
                    { 6, new DateTime(2023, 11, 19, 0, 29, 49, 463, DateTimeKind.Local).AddTicks(6585), 2, "", 1, 2, 5 }
                });

            migrationBuilder.InsertData(
                table: "Slike",
                columns: new[] { "SlikaId", "Path" },
                values: new object[,]
                {
                    { 1, "C:\\Code\\FIT-RS2-2023\\eStomatolog\\eStomatolog\\images/klinika1232424109.jpg" },
                    { 2, "C:\\Code\\FIT-RS2-2023\\eStomatolog\\eStomatolog\\images/klinika2232404361.jpg" },
                    { 3, "C:\\Code\\FIT-RS2-2023\\eStomatolog\\eStomatolog\\images/klinika2232321330.jpg" }
                });

            migrationBuilder.InsertData(
                table: "OrdinacijaSlike",
                columns: new[] { "OrdinacijaId", "SlikaId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 2, 2 },
                    { 3, 3 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Dijagnoze");

            migrationBuilder.DropTable(
                name: "DoktoriOrdinacije");

            migrationBuilder.DropTable(
                name: "DoktoriSpecijalizacije");

            migrationBuilder.DropTable(
                name: "DoktorSlike");

            migrationBuilder.DropTable(
                name: "KorisnikKartice");

            migrationBuilder.DropTable(
                name: "KorisnikUloge");

            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DropTable(
                name: "OrdinacijaSlike");

            migrationBuilder.DropTable(
                name: "PacijentiOrdinacije");

            migrationBuilder.DropTable(
                name: "Placanja");

            migrationBuilder.DropTable(
                name: "PoklonBoni");

            migrationBuilder.DropTable(
                name: "Recepti");

            migrationBuilder.DropTable(
                name: "Rezervacije");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "Usluge");

            migrationBuilder.DropTable(
                name: "Specijalizacije");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Slike");

            migrationBuilder.DropTable(
                name: "Doktori");

            migrationBuilder.DropTable(
                name: "Ordinacije");

            migrationBuilder.DropTable(
                name: "Pacijenti");

            migrationBuilder.DropTable(
                name: "Termini");

            migrationBuilder.DropTable(
                name: "VrstaUsluge");

            migrationBuilder.DropTable(
                name: "Gradovi");

            migrationBuilder.DropTable(
                name: "Korisnik");


            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 1, 2 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 1, 3 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 2, 1 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 2, 2 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 2, 3 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 3, 1 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 3, 2 });

            migrationBuilder.DeleteData(
                table: "DoktoriOrdinacije",
                keyColumns: new[] { "DoktorId", "OrdinacijaId" },
                keyValues: new object[] { 3, 3 });

            migrationBuilder.DeleteData(
                table: "DoktoriSpecijalizacije",
                keyColumn: "DoktorSpecijalizacijaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "DoktoriSpecijalizacije",
                keyColumn: "DoktorSpecijalizacijaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "DoktoriSpecijalizacije",
                keyColumn: "DoktorSpecijalizacijaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "DoktoriSpecijalizacije",
                keyColumn: "DoktorSpecijalizacijaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "KorisnikUloge",
                keyColumn: "KorisnikUlogaID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 2, 1 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 3, 1 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 1, 2 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 2, 2 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 3, 2 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 1, 3 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 2, 3 });

            migrationBuilder.DeleteData(
                table: "PacijentiOrdinacije",
                keyColumns: new[] { "OrdinacijaId", "PacijentId" },
                keyValues: new object[] { 3, 3 });

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Termini",
                keyColumn: "TerminId",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Doktori",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Doktori",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Doktori",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ordinacije",
                keyColumn: "OrdinacijaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ordinacije",
                keyColumn: "OrdinacijaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ordinacije",
                keyColumn: "OrdinacijaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Pacijenti",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Pacijenti",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Pacijenti",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uloge",
                keyColumn: "UlogaID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Uloge",
                keyColumn: "UlogaID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Gradovi",
                keyColumn: "GradId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Gradovi",
                keyColumn: "GradId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Gradovi",
                keyColumn: "GradId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Korisnik",
                keyColumn: "KorisnikID",
                keyValue: 6);

            migrationBuilder.InsertData(
                table: "Gradovi",
                columns: new[] { "GradId", "Naziv" },
                values: new object[,]
                {
                    { 4, "Zenica" },
                    { 5, "Sarajevo" },
                    { 6, "Mostar" }
                });

            migrationBuilder.UpdateData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 2,
                column: "Naziv",
                value: "Oralna hirurgija");

            migrationBuilder.UpdateData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 3,
                column: "Naziv",
                value: "Ortodoncija");

            migrationBuilder.UpdateData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 4,
                column: "Naziv",
                value: "Endodoncija");

            migrationBuilder.UpdateData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 5,
                column: "Naziv",
                value: "Parodontologija");

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[] { 6, "Oralna patologija" });

            migrationBuilder.InsertData(
                table: "Usluge",
                columns: new[] { "Id", "Cijena", "Naziv", "Opis" },
                values: new object[] { 2, 50m, "Popravka karijesa", "Popravka karijesa uključuje brusenja zuba i stavljanje plombe" });

            migrationBuilder.InsertData(
                table: "VrstaUsluge",
                columns: new[] { "VrstaUslugeId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Redovno cišcenje zuba" },
                    { 2, "Popravka karijesa" },
                    { 3, "Izbeljivanje zuba pomocu gela" }
                });

            migrationBuilder.DeleteData(
                table: "Dijagnoze",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Dijagnoze",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Dijagnoze",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Ocjene",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "OrdinacijaSlike",
                keyColumns: new[] { "OrdinacijaId", "SlikaId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "OrdinacijaSlike",
                keyColumns: new[] { "OrdinacijaId", "SlikaId" },
                keyValues: new object[] { 2, 2 });

            migrationBuilder.DeleteData(
                table: "OrdinacijaSlike",
                keyColumns: new[] { "OrdinacijaId", "SlikaId" },
                keyValues: new object[] { 3, 3 });

            migrationBuilder.DeleteData(
                table: "PoklonBoni",
                keyColumn: "PoklonBonId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PoklonBoni",
                keyColumn: "PoklonBonId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PoklonBoni",
                keyColumn: "PoklonBonId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "RezervacijaId",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaId",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Slike",
                keyColumn: "SlikaId",
                keyValue: 3);
        }
    }
}
