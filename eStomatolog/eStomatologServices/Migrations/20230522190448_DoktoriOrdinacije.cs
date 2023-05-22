using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class DoktoriOrdinacije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Doktori_Ordinacija_OrdinacijaId",
                table: "Doktori");

            migrationBuilder.DropIndex(
                name: "IX_Doktori_OrdinacijaId",
                table: "Doktori");

          


            migrationBuilder.DropColumn(
                name: "OrdinacijaId",
                table: "Doktori");

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
                        name: "FK_DoktoriOrdinacije_Ordinacija_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacija",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriOrdinacije_OrdinacijaId",
                table: "DoktoriOrdinacije",
                column: "OrdinacijaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DoktoriOrdinacije");

            migrationBuilder.AddColumn<int>(
                name: "OrdinacijaId",
                table: "Doktori",
                type: "int",
                nullable: true);

            

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_OrdinacijaId",
                table: "Doktori",
                column: "OrdinacijaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Doktori_Ordinacija_OrdinacijaId",
                table: "Doktori",
                column: "OrdinacijaId",
                principalTable: "Ordinacija",
                principalColumn: "OrdinacijaId");
        }
    }
}
