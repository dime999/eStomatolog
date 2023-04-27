using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class KoriosnikUloge : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikUloge_Korisnik_KorisnikID",
                table: "KorisnikUloge");

            migrationBuilder.DropForeignKey(
                name: "FK_KorisnikUloge_Uloge_UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.DropIndex(
                name: "IX_KorisnikUloge_UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.DropColumn(
                name: "UlogeUlogaId",
                table: "KorisnikUloge");

            migrationBuilder.RenameColumn(
                name: "KorisniciUlogeID",
                table: "KorisnikUloge",
                newName: "KorisnikUlogaID");

            migrationBuilder.RenameColumn(
                name: "KorisnikId",
                table: "Korisnik",
                newName: "KorisnikID");

            migrationBuilder.AlterColumn<DateTime>(
                name: "DatumIzmjene",
                table: "KorisnikUloge",
                type: "datetime",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AlterColumn<string>(
                name: "Telefon",
                table: "Korisnik",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<bool>(
                name: "Status",
                table: "Korisnik",
                type: "bit",
                nullable: false,
                defaultValueSql: "((1))",
                oldClrType: typeof(bool),
                oldType: "bit",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Prezime",
                table: "Korisnik",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "LozinkaSalt",
                table: "Korisnik",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "LozinkaHash",
                table: "Korisnik",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "KorisnickoIme",
                table: "Korisnik",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "Ime",
                table: "Korisnik",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Korisnik",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogaID",
                table: "KorisnikUloge",
                column: "UlogaID");

            migrationBuilder.CreateIndex(
                name: "CS_Email",
                table: "Korisnik",
                column: "Email",
                unique: true,
                filter: "[Email] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "CS_KorisnickoIme",
                table: "Korisnik",
                column: "KorisnickoIme",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_KorisniciUloge_Korisnici",
                table: "KorisnikUloge",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikID");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisniciUloge_Uloge",
                table: "KorisnikUloge",
                column: "UlogaID",
                principalTable: "Uloge",
                principalColumn: "UlogaID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_KorisniciUloge_Korisnici",
                table: "KorisnikUloge");

            migrationBuilder.DropForeignKey(
                name: "FK_KorisniciUloge_Uloge",
                table: "KorisnikUloge");

            migrationBuilder.DropIndex(
                name: "IX_KorisnikUloge_UlogaID",
                table: "KorisnikUloge");

            migrationBuilder.DropIndex(
                name: "CS_Email",
                table: "Korisnik");

            migrationBuilder.DropIndex(
                name: "CS_KorisnickoIme",
                table: "Korisnik");

            migrationBuilder.RenameColumn(
                name: "KorisnikUlogaID",
                table: "KorisnikUloge",
                newName: "KorisniciUlogeID");

            migrationBuilder.RenameColumn(
                name: "KorisnikID",
                table: "Korisnik",
                newName: "KorisnikId");

            migrationBuilder.AlterColumn<DateTime>(
                name: "DatumIzmjene",
                table: "KorisnikUloge",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime");

            migrationBuilder.AddColumn<int>(
                name: "UlogeUlogaId",
                table: "KorisnikUloge",
                type: "int",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Telefon",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20,
                oldNullable: true);

            migrationBuilder.AlterColumn<bool>(
                name: "Status",
                table: "Korisnik",
                type: "bit",
                nullable: true,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValueSql: "((1))");

            migrationBuilder.AlterColumn<string>(
                name: "Prezime",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<string>(
                name: "LozinkaSalt",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<string>(
                name: "LozinkaHash",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<string>(
                name: "KorisnickoIme",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<string>(
                name: "Ime",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<string>(
                name: "Email",
                table: "Korisnik",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100,
                oldNullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_KorisnikUloge_UlogeUlogaId",
                table: "KorisnikUloge",
                column: "UlogeUlogaId");

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikUloge_Korisnik_KorisnikID",
                table: "KorisnikUloge",
                column: "KorisnikID",
                principalTable: "Korisnik",
                principalColumn: "KorisnikId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_KorisnikUloge_Uloge_UlogeUlogaId",
                table: "KorisnikUloge",
                column: "UlogeUlogaId",
                principalTable: "Uloge",
                principalColumn: "UlogaID");
        }
    }
}
