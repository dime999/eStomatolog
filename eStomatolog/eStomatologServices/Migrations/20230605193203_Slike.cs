using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Slike : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Slike",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Path = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Slike", x => x.SlikaId);
                });

            migrationBuilder.CreateTable(
                name: "OrdinacijaSlike",
                columns: table => new
                {
                    SlikaId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ordinacija_slika", x => new { x.OrdinacijaId, x.SlikaId });
                    table.ForeignKey(
                        name: "FK_OrdinacijaSlike_Ordinacije_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacije",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_OrdinacijaSlike_Slike_SlikaId",
                        column: x => x.SlikaId,
                        principalTable: "Slike",
                        principalColumn: "SlikaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_OrdinacijaSlike_SlikaId",
                table: "OrdinacijaSlike",
                column: "SlikaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "OrdinacijaSlike");

            migrationBuilder.DropTable(
                name: "Slike");
        }
    }
}
