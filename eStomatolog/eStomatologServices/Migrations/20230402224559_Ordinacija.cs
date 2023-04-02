using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Ordinacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OrdinacijaId",
                table: "Doktori",
                type: "int",
                nullable: true);

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

            migrationBuilder.InsertData(
                table: "Ordinacija",
                columns: new[] { "Id", "Adresa", "Drzava", "Grad", "Naziv", "Telefon" },
                values: new object[,]
                {
                    { 1, "Crkvice 40", "Bosna i Hercegovina", "Zenica", "Ordinacija 1", "061111111" },
                    { 2, "Hamida Vuka 41", "Bosna i Hercegovina", "Mostar", "Ordinacija 2", "061111112" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_OrdinacijaId",
                table: "Doktori",
                column: "OrdinacijaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Doktori_Ordinacija_OrdinacijaId",
                table: "Doktori",
                column: "OrdinacijaId",
                principalTable: "Ordinacija",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Doktori_Ordinacija_OrdinacijaId",
                table: "Doktori");

            migrationBuilder.DropTable(
                name: "Ordinacija");

            migrationBuilder.DropIndex(
                name: "IX_Doktori_OrdinacijaId",
                table: "Doktori");

            migrationBuilder.DropColumn(
                name: "OrdinacijaId",
                table: "Doktori");
        }
    }
}
