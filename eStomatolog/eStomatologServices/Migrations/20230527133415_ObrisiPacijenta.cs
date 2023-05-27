using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class ObrisiPacijenta : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Dijagnoze_Pacijenti_PacijentId",
                table: "Dijagnoze");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Pacijenti_PacijentId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropForeignKey(
                name: "FK_Placanja_Pacijenti_PacijentId",
                table: "Placanja");

            migrationBuilder.DropForeignKey(
                name: "FK_Recepti_Pacijenti_PacijentId",
                table: "Recepti");

            migrationBuilder.DropForeignKey(
                name: "FK_Termini_Pacijenti_PacijentID",
                table: "Termini");

            migrationBuilder.DropTable(
                name: "Pacijenti");

            migrationBuilder.DropIndex(
                name: "IX_Termini_PacijentID",
                table: "Termini");

            migrationBuilder.DropIndex(
                name: "IX_Recepti_PacijentId",
                table: "Recepti");

            migrationBuilder.DropIndex(
                name: "IX_Placanja_PacijentId",
                table: "Placanja");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Dijagnoze_PacijentId",
                table: "Dijagnoze");

            

            migrationBuilder.AddColumn<int>(
                name: "OrdinacijaId1",
                table: "PacijentiOrdinacije",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId1",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId1");

            migrationBuilder.AddForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId1",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId1",
                principalTable: "Ordinacija",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId1",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId1",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropColumn(
                name: "OrdinacijaId1",
                table: "PacijentiOrdinacije");

            migrationBuilder.AlterColumn<int>(
                name: "OrdinacijaId",
                table: "PacijentiOrdinacije",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .OldAnnotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije",
                columns: new[] { "PacijentId", "OrdinacijaId" });

            migrationBuilder.CreateTable(
                name: "Pacijenti",
                columns: table => new
                {
                    PacijentId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GradId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    BrojTelefona = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Pacijent__3214EC075A0E6AA8", x => x.PacijentId);
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

            migrationBuilder.CreateIndex(
                name: "IX_Termini_PacijentID",
                table: "Termini",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Recepti_PacijentId",
                table: "Recepti",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Placanja_PacijentId",
                table: "Placanja",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Dijagnoze_PacijentId",
                table: "Dijagnoze",
                column: "PacijentId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_GradId",
                table: "Pacijenti",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_KorisnikId",
                table: "Pacijenti",
                column: "KorisnikId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Dijagnoze_Pacijenti_PacijentId",
                table: "Dijagnoze",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacija",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PacijentiOrdinacije_Pacijenti_PacijentId",
                table: "PacijentiOrdinacije",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Placanja_Pacijenti_PacijentId",
                table: "Placanja",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Recepti_Pacijenti_PacijentId",
                table: "Recepti",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Termini_Pacijenti_PacijentID",
                table: "Termini",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
