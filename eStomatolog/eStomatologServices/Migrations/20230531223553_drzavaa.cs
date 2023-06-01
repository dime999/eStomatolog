using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class drzavaa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Drzava",
                table: "Ordinacija");



            migrationBuilder.AddColumn<int>(
                name: "PacijentId",
                table: "Ordinacija",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Ordinacija_PacijentId",
                table: "Ordinacija",
                column: "PacijentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Drzava",
                table: "Ordinacija",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");



            migrationBuilder.DropForeignKey(
                name: "FK_Ordinacija_Pacijenti_PacijentId",
                table: "Ordinacija");

            migrationBuilder.DropIndex(
                name: "IX_Ordinacija_PacijentId",
                table: "Ordinacija");

            migrationBuilder.DropColumn(
                name: "PacijentId",
                table: "Ordinacija");
        }
    }
}
