using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class ini : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Korisnik",
                columns: table => new
                {
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnik", x => x.KorisnikId);
                });

            migrationBuilder.CreateTable(
                name: "Ordinacija",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Grad = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Drzava = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ordinacija", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Pacijenti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Napomene = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Pacijent__3214EC075A0E6AA8", x => x.Id);
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
                name: "Doktori",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Specijalnost = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Doktori__3214EC07B54830FE", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Doktori_Ordinacija_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacija",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Placanja",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentID = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Iznos = table.Column<decimal>(type: "decimal(10,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Placanja__3214EC0781ED2050", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Placanja__Pacije__5BE2A6F2",
                        column: x => x.PacijentID,
                        principalTable: "Pacijenti",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "KorisnikUloge",
                columns: table => new
                {
                    KorisniciUlogeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: false),
                    UlogaID = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UlogeUlogaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisnikUloge", x => x.KorisniciUlogeID);
                    table.ForeignKey(
                        name: "FK_KorisnikUloge_Korisnik_KorisnikID",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnik",
                        principalColumn: "KorisnikId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisnikUloge_Uloge_UlogeUlogaId",
                        column: x => x.UlogeUlogaId,
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
                name: "Dijagnoze",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentID = table.Column<int>(type: "int", nullable: false),
                    DoktorID = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Dijagnoz__3214EC07B6723559", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Dijagnoze__Dokto__5535A963",
                        column: x => x.DoktorID,
                        principalTable: "Doktori",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Dijagnoze__Pacij__5441852A",
                        column: x => x.PacijentID,
                        principalTable: "Pacijenti",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Recepti",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentID = table.Column<int>(type: "int", nullable: false),
                    DoktorID = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Recepti__3214EC07612C3916", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Recepti__DoktorI__59063A47",
                        column: x => x.DoktorID,
                        principalTable: "Doktori",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Recepti__Pacijen__5812160E",
                        column: x => x.PacijentID,
                        principalTable: "Pacijenti",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Termini",
                columns: table => new
                {
                    TerminID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentID = table.Column<int>(type: "int", nullable: false),
                    DoktorID = table.Column<int>(type: "int", nullable: false),
                    UslugaID = table.Column<int>(type: "int", nullable: false),
                    DatumVrijeme = table.Column<DateTime>(type: "datetime", nullable: false),
                    Napomena = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Termini__42126CB53F850D3A", x => x.TerminID);
                    table.ForeignKey(
                        name: "FK__Termini__DoktorI__5070F446",
                        column: x => x.DoktorID,
                        principalTable: "Doktori",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Termini__Pacijen__4F7CD00D",
                        column: x => x.PacijentID,
                        principalTable: "Pacijenti",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Termini__UslugaI__5165187F",
                        column: x => x.UslugaID,
                        principalTable: "Usluge",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "Ordinacija",
                columns: new[] { "Id", "Adresa", "Drzava", "Grad", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 1, "Crkvice 40", "Bosna i Hercegovina", "Zenica", "Ordinacija 1", "061111111" },
                    { 2, "Hamida Vuka 41", "Bosna i Hercegovina", "Mostar", "Ordinacija 2", "061111112" }
                });

            migrationBuilder.InsertData(
                table: "VrstaUsluge",
                columns: new[] { "VrstaUslugeId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Redovno cišcenje zuba" },
                    { 2, "Popravka karijesa" },
                    { 3, "Izbeljivanje zuba pomocu gela" }
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
                name: "IX_Doktori_OrdinacijaId",
                table: "Doktori",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_KorisnikID",
                table: "KorisnikUloge",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogeUlogaId",
                table: "KorisnikUloge",
                column: "UlogeUlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Placanja_PacijentID",
                table: "Placanja",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Recepti_DoktorID",
                table: "Recepti",
                column: "DoktorID");

            migrationBuilder.CreateIndex(
                name: "IX_Recepti_PacijentID",
                table: "Recepti",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_DoktorID",
                table: "Termini",
                column: "DoktorID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_PacijentID",
                table: "Termini",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_UslugaID",
                table: "Termini",
                column: "UslugaID");

            migrationBuilder.CreateIndex(
                name: "IX_Usluga_VrstaUslugeId",
                table: "Usluga",
                column: "VrstaUslugeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Dijagnoze");

            migrationBuilder.DropTable(
                name: "KorisnikUloge");

            migrationBuilder.DropTable(
                name: "Placanja");

            migrationBuilder.DropTable(
                name: "Recepti");

            migrationBuilder.DropTable(
                name: "Termini");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "Korisnik");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Doktori");

            migrationBuilder.DropTable(
                name: "Pacijenti");

            migrationBuilder.DropTable(
                name: "Usluge");

            migrationBuilder.DropTable(
                name: "VrstaUsluge");

            migrationBuilder.DropTable(
                name: "Ordinacija");
        }
    }
}
