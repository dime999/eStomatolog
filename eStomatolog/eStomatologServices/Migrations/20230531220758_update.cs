using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class update : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.AddColumn<int>(
                name: "PacijentId",
                table: "Ordinacija",
                type: "int",
                nullable: true);



        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropColumn(
                name: "PacijentId",
                table: "Ordinacija");
        }
    }
}
