using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class updateOrdinacije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Ordinacija",
                newName: "OrdinacijaId");

            migrationBuilder.AddColumn<byte[]>(
                name: "Slika",
                table: "Ordinacija",
                type: "varbinary(max)",
                nullable: false,
                defaultValue: new byte[0]);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
          
        }
    }
}
