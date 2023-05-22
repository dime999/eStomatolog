using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class doktorispecijalizacije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropForeignKey(
                name: "FK_Specijalizacije_Doktori_SpecijalizacijaId",
                table: "Specijalizacije");

           
        

            migrationBuilder.DropColumn(
                name: "SpecijalizacijaId",
                table: "Doktori");

         

            migrationBuilder.DropColumn(
                name: "Specijalnost",
                table: "Doktori");

           

            migrationBuilder.AlterColumn<int>(
            name: "SpecijalizacijaId",
            table: "Specijalizacije",
            type: "int",
            nullable: false,
            oldClrType: typeof(int),
            oldType: "int");

            


            migrationBuilder.CreateTable(
                name: "DoktoriSpecijalizacije",
                columns: table => new
                {
                    DoktorSpecijalizacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DoktorId = table.Column<int>(type: "int", nullable: false),
                    SpecijalizacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DoktoriSpecijalizacije", x => x.DoktorSpecijalizacijaId);
                    table.ForeignKey(
                        name: "FK_DoktoriSpecijalizacije_Doktori",
                        column: x => x.DoktorId,
                        principalTable: "Doktori",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_DoktoriSpecijalizacije_Specijalizacija",
                        column: x => x.SpecijalizacijaId,
                        principalTable: "Specijalizacije",
                        principalColumn: "SpecijalizacijaId");
                });

          

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriSpecijalizacije_DoktorId",
                table: "DoktoriSpecijalizacije",
                column: "DoktorId");

            migrationBuilder.CreateIndex(
                name: "IX_DoktoriSpecijalizacije_SpecijalizacijaId",
                table: "DoktoriSpecijalizacije",
                column: "SpecijalizacijaId");

         

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Doktori_DoktorId",
                table: "Ocjene",
                column: "DoktorId",
                principalTable: "Doktori",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.DropTable(
                name: "DoktoriSpecijalizacije");

           

      

         

            migrationBuilder.AddColumn<string>(
                name: "Specijalnost",
                table: "Doktori",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

          


            migrationBuilder.AddForeignKey(
                name: "FK_Specijalizacije_Doktori_SpecijalizacijaId",
                table: "Specijalizacije",
                column: "SpecijalizacijaId",
                principalTable: "Doktori",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

          
        }
    }
}
