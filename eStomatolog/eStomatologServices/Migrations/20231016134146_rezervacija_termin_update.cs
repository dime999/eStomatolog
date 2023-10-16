using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class rezervacija_termin_update : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropForeignKey(
                name: "FK__Termini__UslugaI__5165187F",
                table: "Termini");

            migrationBuilder.DropIndex(
                name: "IX_Termini_DoktorID",
                table: "Termini");

            migrationBuilder.DropColumn(
                name: "DatumVrijeme",
                table: "Termini");


            migrationBuilder.DropColumn(
                name: "Napomena",
                table: "Termini");

            migrationBuilder.DropColumn(
                name: "PacijentID",
                table: "Termini");

            migrationBuilder.DropColumn(
                name: "Do",
                table: "Rezervacije");

            migrationBuilder.RenameColumn(
                name: "UslugaID",
                table: "Termini",
                newName: "UslugaId");

            migrationBuilder.RenameIndex(
                name: "IX_Termini_UslugaID",
                table: "Termini",
                newName: "IX_Termini_UslugaId");

            migrationBuilder.RenameColumn(
                name: "Od",
                table: "Rezervacije",
                newName: "Datum");

            migrationBuilder.AlterColumn<int>(
                name: "UslugaId",
                table: "Termini",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<string>(
                name: "Vrijeme",
                table: "Termini",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "TerminID",
                table: "Rezervacije",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_TerminId",
                table: "Rezervacije",
                column: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Termini_Usluge_UslugaId",
                table: "Termini",
                column: "UslugaId",
                principalTable: "Usluge",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Termini_TerminId",
                table: "Rezervacije");

            migrationBuilder.DropForeignKey(
                name: "FK_Termini_Usluge_UslugaId",
                table: "Termini");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_TerminId",
                table: "Rezervacije");

            migrationBuilder.DropColumn(
                name: "Vrijeme",
                table: "Termini");

            migrationBuilder.DropColumn(
                name: "TerminID",
                table: "Rezervacije");

            migrationBuilder.RenameColumn(
                name: "UslugaId",
                table: "Termini",
                newName: "UslugaID");

            migrationBuilder.RenameIndex(
                name: "IX_Termini_UslugaId",
                table: "Termini",
                newName: "IX_Termini_UslugaID");

            migrationBuilder.RenameColumn(
                name: "Datum",
                table: "Rezervacije",
                newName: "Od");

            migrationBuilder.AlterColumn<int>(
                name: "UslugaID",
                table: "Termini",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DatumVrijeme",
                table: "Termini",
                type: "datetime",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<int>(
                name: "DoktorID",
                table: "Termini",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Napomena",
                table: "Termini",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PacijentID",
                table: "Termini",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "Do",
                table: "Rezervacije",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.CreateIndex(
                name: "IX_Termini_DoktorID",
                table: "Termini",
                column: "DoktorID");

            migrationBuilder.AddForeignKey(
                name: "FK_Termini_Doktori_DoktorID",
                table: "Termini",
                column: "DoktorID",
                principalTable: "Doktori",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK__Termini__UslugaI__5165187F",
                table: "Termini",
                column: "UslugaID",
                principalTable: "Usluge",
                principalColumn: "Id");
        }
    }
}
