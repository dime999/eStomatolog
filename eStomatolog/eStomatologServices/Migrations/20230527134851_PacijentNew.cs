using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class PacijentNew : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

           

            migrationBuilder.AddPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije",
                columns: new[] { "PacijentId", "OrdinacijaId" });

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

            migrationBuilder.CreateIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId");

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
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Pacijenti_PacijentId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropTable(
                name: "Pacijenti");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PacijentiOrdinacije",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije");

            migrationBuilder.AlterColumn<int>(
                name: "OrdinacijaId",
                table: "PacijentiOrdinacije",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int")
                .Annotation("SqlServer:Identity", "1, 1");

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
    }
}
