using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class DrzavaDelete : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Drzava",
                table: "Ordinacija");

            migrationBuilder.DropForeignKey(
              name: "FK_Ordinacija_Pacijenti_PacijentId",
              table: "Ordinacija");

            migrationBuilder.AlterColumn<int>(
                name: "PacijentId",
                table: "Ordinacija",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

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

            migrationBuilder.AlterColumn<int>(
                name: "PacijentId",
                table: "Ordinacija",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);
        }
    }
}
