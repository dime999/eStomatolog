using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eStomatologServices.Migrations
{
    /// <inheritdoc />
    public partial class poacijenti : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
           
           
           
     

          

         

            migrationBuilder.Sql("SET IDENTITY_INSERT Pacijenti ON");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
           

            migrationBuilder.Sql("SET IDENTITY_INSERT Pacijenti OFF");
        }
    }
}
