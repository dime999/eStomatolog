using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class OrdincijaGrad : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "GradId",
                table: "Ordinacije",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Ordinacije_GradId",
                table: "Ordinacije",
                column: "GradId");

            migrationBuilder.AddForeignKey(
                name: "FK_Ordinacije_Gradovi_GradId",
                table: "Ordinacije",
                column: "GradId",
                principalTable: "Gradovi",
                principalColumn: "GradId",
                onDelete: ReferentialAction.NoAction);

        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ordinacije_Gradovi_GradId",
                table: "Ordinacije");

            migrationBuilder.DropIndex(
                name: "IX_Ordinacije_GradId",
                table: "Ordinacije");

            migrationBuilder.DropColumn(
                name: "GradId",
                table: "Ordinacije");
        }
    }
}
