using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Ocjene : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Ocjene",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    Datum = table.Column<DateTime>(type: "datetime", nullable: false),
                    Ocjena = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjene", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Ocjene_Doktor",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Ocjene_Pacijent",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "Usluge",
                columns: new[] { "Id", "Cijena", "Naziv", "Opis" },
                values: new object[] { 2, 50m, "Popravka karijesa", "Popravka karijesa uključuje brusenja zuba i stavljanje plombe" });

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_DoktorId",
                table: "Ocjene",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene",
                column: "PacijentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DeleteData(
                table: "Usluge",
                keyColumn: "Id",
                keyValue: 2);
        }
    }
}
