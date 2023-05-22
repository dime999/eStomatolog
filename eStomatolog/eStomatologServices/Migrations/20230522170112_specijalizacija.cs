using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class specijalizacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
           

            migrationBuilder.AddColumn<int>(
                name: "SpecijalizacijaId",
                table: "Doktori",
                type: "int",
                nullable: false,
                defaultValue: 0);


            migrationBuilder.CreateTable(
                name: "Specijalizacije",
                columns: table => new
                {
                    SpecijalizacijaId = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Specijalizacije", x => x.SpecijalizacijaId);
                    table.ForeignKey(
                        name: "FK_Specijalizacije_Doktori_SpecijalizacijaId",
                        column: x => x.SpecijalizacijaId,
                        principalTable: "Doktori",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

           

          
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.DropTable(
                name: "Specijalizacije");

           

          

            migrationBuilder.DropColumn(
                name: "SpecijalizacijaId",
                table: "Doktori");

          
        }
    }
}
