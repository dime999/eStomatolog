using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Dijagnoza : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PacijentID",
                table: "Dijagnoze",
                newName: "PacijentId");

          

            migrationBuilder.CreateIndex(
                name: "IX_Dijagnoze_PacijentID",
                table: "Dijagnoze",
                column: "PacijentID");

            migrationBuilder.AddForeignKey(
                name: "FK_Dijagnoze_Pacijenti_PacijentID",
                table: "Dijagnoze",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.RenameColumn(
                name: "PacijentID",
                table: "Dijagnoze",
                newName: "PacijentId");

        }
    }
}
