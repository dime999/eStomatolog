using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class updateRezervacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
          
            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_OrdinacijaId",
                table: "Rezervacije",
                column: "OrdinacijaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Ordinacije_OrdinacijaId",
                table: "Rezervacije",
                column: "OrdinacijaId",
                principalTable: "Ordinacije",
                principalColumn: "OrdinacijaId",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_TerminId",
                table: "Termini",
                column: "TerminId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Termini_TerminId",
                table: "Rezervacije",
                column: "TerminId",
                principalTable: "Termini",
                principalColumn: "TerminId",
                onDelete: ReferentialAction.Restrict);


            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_PacijentId",
                table: "Rezervacije",
                column: "PacijentId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Pacijenti_PacijentId",
                table: "Rezervacije",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_DoktorId",
                table: "Rezervacije",
                column: "DoktorId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Doktori_DoktorId",
                table: "Rezervacije",
                column: "DoktorId",
                principalTable: "Doktori",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
           
            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Ordinacije_OrdinacijaId",
                table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_OrdinacijaId",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
               name: "FK_Rezervacije_Termini_TerminId",
               table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_TerminId",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Pacijenti_PacijentId",
                table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_PacijentId",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Doktori_DoktorId",
                table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_DoktorId",
                table: "Rezervacije");
        }
    }
}

