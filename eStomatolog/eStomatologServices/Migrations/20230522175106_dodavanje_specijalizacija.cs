using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class dodavanje_specijalizacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 1);

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[,]
                {
                    { 2, "Oralna hirurgija" },
                    { 3, "Ortodoncija" },
                    { 4, "Endodoncija" },
                    { 5, "Parodontologija" },
                    { 6, "Oralna patologija" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Specijalizacije",
                keyColumn: "SpecijalizacijaId",
                keyValue: 6);

            migrationBuilder.InsertData(
                table: "Specijalizacije",
                columns: new[] { "SpecijalizacijaId", "Naziv" },
                values: new object[] { 1, "Oralna hirurgija" });
        }
    }
}
