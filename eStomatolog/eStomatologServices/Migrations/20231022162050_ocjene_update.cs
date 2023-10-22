using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class ocjene_update : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene",
                column: "PacijentId");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_PacijentId",
                table: "Ocjene");
        }
    }
}
