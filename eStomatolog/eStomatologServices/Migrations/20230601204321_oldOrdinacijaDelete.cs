using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class oldOrdinacijaDelete : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DoktoriOrdinacije_Ordinacija_OrdinacijaId",
                table: "DoktoriOrdinacije");

            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                table: "PacijentiOrdinacije");

            migrationBuilder.DropTable(
                name: "Ordinacija");

            migrationBuilder.AddForeignKey(
                name: "FK_DoktoriOrdinacije_Ordinacije_OrdinacijaId",
                table: "DoktoriOrdinacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacije",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacije_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacije",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_DoktoriOrdinacije_Ordinacije_OrdinacijaId",
                table: "DoktoriOrdinacije");

            migrationBuilder.DropForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacije_OrdinacijaId",
                table: "PacijentiOrdinacije");


            migrationBuilder.CreateIndex(
                name: "IX_Ordinacija_PacijentId",
                table: "Ordinacija",
                column: "PacijentId");

            migrationBuilder.AddForeignKey(
                name: "FK_DoktoriOrdinacije_Ordinacija_OrdinacijaId",
                table: "DoktoriOrdinacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacija",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacija",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
