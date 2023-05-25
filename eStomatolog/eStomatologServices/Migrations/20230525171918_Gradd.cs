using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Gradd : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Gradovi",
                columns: table => new
                {
                    GradId = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Gradovi", x => x.GradId);
                });

            migrationBuilder.AddColumn<int>(
                name: "GradId",
                table: "Doktori",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Doktori_GradId",
                table: "Doktori",
                column: "GradId");

            migrationBuilder.AddForeignKey(
               name: "FK_Doktori_Grad_GradId",
               table: "Doktori",
               column: "GradId",
               principalTable: "Gradovi",
               principalColumn: "GradId",
               onDelete: ReferentialAction.Cascade);


        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
              name: "Gradovi");


            migrationBuilder.DropIndex(
                name: "IX_Doktori_GradId",
                table: "Doktori");

            migrationBuilder.DropColumn(
                name: "GradId",
                table: "Doktori");
        }
    }
}
