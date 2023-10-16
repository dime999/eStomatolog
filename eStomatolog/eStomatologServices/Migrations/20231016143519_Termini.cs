using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Termini : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {


            migrationBuilder.CreateTable(
              name: "Termini",
              columns: table => new
              {
                  TerminId = table.Column<int>(nullable: false)
                      .Annotation("SqlServer:Identity", "1, 1"),
                  Vrijeme = table.Column<DateTime>(nullable: false),
                  Opis = table.Column<string>(nullable: true)
              },
              constraints: table =>
              {
                  table.PrimaryKey("PK_Termini", x => x.TerminId);
              });


        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {


            migrationBuilder.DropTable(
              name: "Termini");

        }
    }
}
