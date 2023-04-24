using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Uloge : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisniciUloge_Korisnik_KorisnikID",
                table: "KorisniciUloge");

            migrationBuilder.DropPrimaryKey(
                name: "PK_KorisniciUloge",
                table: "KorisniciUloge");

            migrationBuilder.RenameTable(
                name: "KorisniciUloge",
                newName: "KorisnikUloge");

            migrationBuilder.RenameIndex(
                name: "IX_KorisniciUloge_KorisnikID",
                table: "KorisnikUloge",
                newName: "IX_KorisnikUloge_KorisnikID");

            migrationBuilder.AddColumn<int>(
                name: "UlogeUlogaId",
                table: "KorisnikUloge",
                type: "int",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_KorisnikUloge",
                table: "KorisnikUloge",
                column: "KorisniciUlogeID");

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    VrstaUslugeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloge", x => x.VrstaUslugeId);
                });

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogeUlogaId",
                table: "KorisnikUloge",
                column: "UlogeUlogaId");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikUloge_Korisnik_KorisnikID",
                table: "KorisnikUloge",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikUloge_Uloge_UlogeUlogaId",
                table: "KorisnikUloge",
                column: "UlogeUlogaId",
                principalTable: "Uloge",
                principalColumn: "VrstaUslugeId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikUloge_Korisnik_KorisnikID",
                table: "KorisnikUloge");

            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikUloge_Uloge_UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropPrimaryKey(
                name: "PK_KorisnikUloge",
                table: "KorisnikUloge");

            migrationBuilder.DropIndex(
                name: "IX_KorisnikUloge_UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.DropColumn(
                name: "UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.RenameTable(
                name: "KorisnikUloge",
                newName: "KorisniciUloge");

            migrationBuilder.RenameIndex(
                name: "IX_KorisnikUloge_KorisnikID",
                table: "KorisniciUloge",
                newName: "IX_KorisniciUloge_KorisnikID");

            migrationBuilder.AddPrimaryKey(
                name: "PK_KorisniciUloge",
                table: "KorisniciUloge",
                column: "KorisniciUlogeID");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisniciUloge_Korisnik_KorisnikID",
                table: "KorisniciUloge",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
