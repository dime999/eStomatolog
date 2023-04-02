using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class VrsteUsluge : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Cijena",
                table: "Usluge",
                newName: "Cijena");

            migrationBuilder.RenameColumn(
                name: "DatumVrijeme",
                table: "Termini",
                newName: "DatumVrijeme");

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
                name: "IX_Usluga_VrstaUslugeId",
                table: "Usluga",
                column: "VrstaUslugeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "VrstaUsluge");

            migrationBuilder.RenameColumn(
                name: "Cijena",
                table: "Usluge",
                newName: "Cijena");

            migrationBuilder.RenameColumn(
                name: "DatumVrijeme",
                table: "Termini",
                newName: "DatumVrijeme");
        }
    }
}
