using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class Pacijenti : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Dijagnoze__Pacij__5441852A",
                table: "Dijagnoze");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Pacijent",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK__Placanja__Pacije__5BE2A6F2",
                table: "Placanja");

            migrationBuilder.DropForeignKey(
                name: "FK__Recepti__Pacijen__5812160E",
                table: "Recepti");

            migrationBuilder.DropForeignKey(
                name: "FK__Termini__Pacijen__4F7CD00D",
                table: "Termini");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Pacijent__3214EC075A0E6AA8",
                table: "Pacijenti");

            migrationBuilder.DropColumn(
                name: "Adresa",
                table: "Pacijenti");

            migrationBuilder.DropColumn(
                name: "Napomene",
                table: "Pacijenti");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Pacijenti",
                newName: "KorisnikId");


            migrationBuilder.AddColumn<int>(
                name: "GradId",
                table: "Pacijenti",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
             name: "PacijentId",
             table: "Pacijenti",
             type: "int",
             nullable: false,
             defaultValue: 0);


            migrationBuilder.AddPrimaryKey(
    name: "PK_Pacijenti",
    table: "Pacijenti",
    column: "PacijentId");

            migrationBuilder.CreateTable(
                name: "PacijentiOrdinacije",
                columns: table => new
                {
                    PacijentId = table.Column<int>(type: "int", nullable: false),
                    OrdinacijaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PacijentiOrdinacije", x => new { x.PacijentId, x.OrdinacijaId });
                    table.ForeignKey(
                        name: "FK_PacijentiOrdinacije_Ordinacija_OrdinacijaId",
                        column: x => x.OrdinacijaId,
                        principalTable: "Ordinacija",
                        principalColumn: "OrdinacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PacijentiOrdinacije_Pacijenti_PacijentId",
                        column: x => x.PacijentId,
                        principalTable: "Pacijenti",
                        principalColumn: "PacijentId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_GradId",
                table: "Pacijenti",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_Pacijenti_KorisnikId",
                table: "Pacijenti",
                column: "KorisnikId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_PacijentiOrdinacije_OrdinacijaId",
                table: "PacijentiOrdinacije",
                column: "OrdinacijaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Dijagnoze_Pacijenti_PacijentID",
                table: "Dijagnoze",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            

        

            migrationBuilder.AddForeignKey(
                name: "FK_Placanja_Pacijenti_PacijentID",
                table: "Placanja",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Recepti_Pacijenti_PacijentID",
                table: "Recepti",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Termini_Pacijenti_PacijentID",
                table: "Termini",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "PacijentId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Dijagnoze_Pacijenti_PacijentID",
                table: "Dijagnoze");

            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Pacijenti_PacijentId",
                table: "Ocjene");

            migrationBuilder.DropForeignKey(
                name: "FK_Pacijenti_Gradovi_GradId",
                table: "Pacijenti");

            migrationBuilder.DropForeignKey(
                name: "FK_Pacijenti_Korisnik_KorisnikId",
                table: "Pacijenti");

            migrationBuilder.DropForeignKey(
                name: "FK_Placanja_Pacijenti_PacijentID",
                table: "Placanja");

            migrationBuilder.DropForeignKey(
                name: "FK_Recepti_Pacijenti_PacijentID",
                table: "Recepti");

            migrationBuilder.DropForeignKey(
                name: "FK_Termini_Pacijenti_PacijentID",
                table: "Termini");

            migrationBuilder.DropTable(
                name: "PacijentiOrdinacije");

            migrationBuilder.DropPrimaryKey(
                name: "PK__Pacijent__3214EC075A0E6AA8",
                table: "Pacijenti");

            migrationBuilder.DropIndex(
                name: "IX_Pacijenti_GradId",
                table: "Pacijenti");

            migrationBuilder.DropIndex(
                name: "IX_Pacijenti_KorisnikId",
                table: "Pacijenti");

            migrationBuilder.DropColumn(
                name: "PacijentId",
                table: "Pacijenti");

            migrationBuilder.DropColumn(
                name: "GradId",
                table: "Pacijenti");

            migrationBuilder.RenameColumn(
                name: "KorisnikId",
                table: "Pacijenti",
                newName: "Id");


            migrationBuilder.AddColumn<string>(
                name: "Adresa",
                table: "Pacijenti",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Napomene",
                table: "Pacijenti",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK__Pacijent__3214EC075A0E6AA8",
                table: "Pacijenti",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK__Dijagnoze__Pacij__5441852A",
                table: "Dijagnoze",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Pacijent",
                table: "Ocjene",
                column: "PacijentId",
                principalTable: "Pacijenti",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK__Placanja__Pacije__5BE2A6F2",
                table: "Placanja",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK__Recepti__Pacijen__5812160E",
                table: "Recepti",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK__Termini__Pacijen__4F7CD00D",
                table: "Termini",
                column: "PacijentID",
                principalTable: "Pacijenti",
                principalColumn: "Id");
        }
    }
}
