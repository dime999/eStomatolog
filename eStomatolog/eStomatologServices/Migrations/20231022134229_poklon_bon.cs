using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class poklon_bon : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PoklonBoni",
                columns: table => new
                {
                    PoklonBonId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IznosPlacanja = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    ImePrezimeKorisnikaKojiKoristi = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false),
                    BrojKartice = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumIstekaKartice = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CvcCvvKod = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PoklonBon", x => x.PoklonBonId);
                    table.ForeignKey(
                        name: "FK_PoklonBoni_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PoklonBoni_PacijentId",
                table: "PoklonBoni",
                column: "PacijentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PoklonBoni");
        }
    }
}
