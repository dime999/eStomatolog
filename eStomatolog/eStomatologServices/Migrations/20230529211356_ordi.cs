using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class ordi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
           

            migrationBuilder.DropColumn(
                name: "Slika",
                table: "Ordinacija");

            migrationBuilder.DropColumn(
                name: "Telefon",
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


            migrationBuilder.AddForeignKey(
                name: "FK_DoktoriSpecijalizacije_Specijalizacije_SpecijalizacijaId",
                table: "DoktoriSpecijalizacije",
                column: "SpecijalizacijaId",
                principalTable: "Specijalizacije",
                principalColumn: "SpecijalizacijaId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Ordinacija_Pacijenti_PacijentId",
                table: "Ordinacija",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            

            migrationBuilder.DropForeignKey(
                name: "FK_Ordinacija_Pacijenti_PacijentId",
                table: "Ordinacija");

            migrationBuilder.DropIndex(
                name: "IX_Ordinacija_PacijentId",
                table: "Ordinacija");

            migrationBuilder.DropColumn(
                name: "PacijentId",
                table: "Ordinacija");

            migrationBuilder.AddColumn<byte[]>(
                name: "Slika",
                table: "Ordinacija",
                type: "varbinary(max)",
                nullable: false,
                defaultValue: new byte[0]);

            migrationBuilder.AddColumn<string>(
                name: "Telefon",
                table: "Ordinacija",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_DoktoriSpecijalizacije_Doktori",
                table: "DoktoriSpecijalizacije",
                column: "DoktorId",
                principalTable: "Doktori",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_DoktoriSpecijalizacije_Specijalizacija",
                table: "DoktoriSpecijalizacije",
                column: "SpecijalizacijaId",
                principalTable: "Specijalizacije",
                principalColumn: "SpecijalizacijaId");
        }
    }
}
