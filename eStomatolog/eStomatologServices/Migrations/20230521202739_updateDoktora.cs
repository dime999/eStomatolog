using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class updateDoktora : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Ime",
                table: "Doktori");

            migrationBuilder.DropColumn(
                name: "Prezime",
                table: "Doktori");

            migrationBuilder.AddColumn<int>(
                name: "KorisnikId",
                table: "Doktori",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_KorisnikId",
                table: "Doktori",
                column: "KorisnikId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Doktori_Korisnik_KorisnikId",
                table: "Doktori",
                column: "KorisnikId",
                principalTable: "Korisnik",
                principalColumn: "KorisnikID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Doktori_Korisnik_KorisnikId",
                table: "Doktori");

            migrationBuilder.DropIndex(
                name: "IX_Doktori_KorisnikId",
                table: "Doktori");

            migrationBuilder.DropColumn(
                name: "KorisnikId",
                table: "Doktori");

            migrationBuilder.AddColumn<string>(
                name: "Ime",
                table: "Doktori",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Prezime",
                table: "Doktori",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");
        }
    }
}
