using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class poklon_bon_update : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "OrdinacijaId",
                table: "PoklonBoni",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_PoklonBoni_OrdinacijaId",
                table: "PoklonBoni",
                column: "OrdinacijaId");

            migrationBuilder.AddForeignKey(
                name: "FK_PoklonBoni_Ordinacije_OrdinacijaId",
                table: "PoklonBoni",
                column: "OrdinacijaId",
                principalTable: "Ordinacije",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PoklonBoni_Ordinacije_OrdinacijaId",
                table: "PoklonBoni");

            migrationBuilder.DropIndex(
                name: "IX_PoklonBoni_OrdinacijaId",
                table: "PoklonBoni");

            migrationBuilder.DropColumn(
                name: "OrdinacijaId",
                table: "PoklonBoni");
        }
    }
}
