﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using eStomatologServices;

#nullable disable

namespace eStomatologServices.Migrations
{
    [DbContext(typeof(eStomatologContext))]
    partial class eStomatologContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("eStomatologModel.Usluga", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(18,2)");

                    b.Property<string>("Naziv")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("VrstaUslugeId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("VrstaUslugeId");

                    b.ToTable("Usluga");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktorOrdinacija", b =>
                {
                    b.Property<int>("DoktorId")
                        .HasColumnType("int");

                    b.Property<int>("OrdinacijaId")
                        .HasColumnType("int");

                    b.HasKey("DoktorId", "OrdinacijaId");

                    b.HasIndex("OrdinacijaId");

                    b.ToTable("DoktoriOrdinacije", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktoriSpecijalizacije", b =>
                {
                    b.Property<int>("DoktorSpecijalizacijaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("DoktorSpecijalizacijaId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DoktorSpecijalizacijaId"));

                    b.Property<int>("DoktorId")
                        .HasColumnType("int")
                        .HasColumnName("DoktorId");

                    b.Property<int>("SpecijalizacijaId")
                        .HasColumnType("int")
                        .HasColumnName("SpecijalizacijaId");

                    b.HasKey("DoktorSpecijalizacijaId");

                    b.HasIndex("DoktorId");

                    b.HasIndex("SpecijalizacijaId");

                    b.ToTable("DoktoriSpecijalizacije", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.Grad", b =>
                {
                    b.Property<int>("GradId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("GradId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("GradId");

                    b.ToTable("Gradovi", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.KorisniciUloge", b =>
                {
                    b.Property<int>("KorisnikUlogaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("KorisnikUlogaID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisnikUlogaId"));

                    b.Property<DateTime>("DatumIzmjene")
                        .HasColumnType("datetime");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.Property<int>("UlogaId")
                        .HasColumnType("int")
                        .HasColumnName("UlogaID");

                    b.HasKey("KorisnikUlogaId");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("UlogaId");

                    b.ToTable("KorisnikUloge", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.Ocjene", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("DoktorId")
                        .HasColumnType("int");

                    b.Property<int>("Ocjena")
                        .HasColumnType("int");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("DoktorId");

                    b.HasIndex("PacijentId");

                    b.ToTable("Ocjene", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.Ordinacija", b =>
                {
                    b.Property<int>("OrdinacijaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("OrdinacijaId"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Drzava")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Grad")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Slika")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("OrdinacijaId");

                    b.ToTable("Ordinacija");
                });

            modelBuilder.Entity("eStomatologServices.Database.Specijalizacija", b =>
                {
                    b.Property<int>("SpecijalizacijaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("SpecijalizacijaId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("SpecijalizacijaId");

                    b.ToTable("Specijalizacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.Uloge", b =>
                {
                    b.Property<int>("UlogaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("UlogaID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UlogaId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Opis")
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.HasKey("UlogaId");

                    b.ToTable("Uloge");
                });

            modelBuilder.Entity("eStomatologServices.Database.VrstaUsluge", b =>
                {
                    b.Property<int>("VrstaUslugeId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("VrstaUslugeId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("VrstaUslugeId"));

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("VrstaUslugeId");

                    b.ToTable("VrstaUsluge");
                });

            modelBuilder.Entity("eStomatologServices.Models.Dijagnoza", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("DoktorId")
                        .HasColumnType("int")
                        .HasColumnName("DoktorID");

                    b.Property<string>("Opis")
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

                    b.HasKey("Id")
                        .HasName("PK__Dijagnoz__3214EC07B6723559");

                    b.HasIndex("DoktorId");

                    b.HasIndex("PacijentId");

                    b.ToTable("Dijagnoze", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Doktor", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("GradId")
                        .HasColumnType("int");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id")
                        .HasName("PK__Doktori__3214EC07B54830FE");

                    b.HasIndex("GradId");

                    b.HasIndex("KorisnikId")
                        .IsUnique();

                    b.ToTable("Doktori", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Korisnik", b =>
                {
                    b.Property<int>("KorisnikId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisnikId"));

                    b.Property<string>("Email")
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("KorisnickoIme")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("LozinkaHash")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("LozinkaSalt")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<bool?>("Status")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasColumnType("bit")
                        .HasDefaultValueSql("((1))");

                    b.Property<string>("Telefon")
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.HasKey("KorisnikId");

                    b.HasIndex(new[] { "Email" }, "CS_Email")
                        .IsUnique()
                        .HasFilter("[Email] IS NOT NULL");

                    b.HasIndex(new[] { "KorisnickoIme" }, "CS_KorisnickoIme")
                        .IsUnique();

                    b.ToTable("Korisnik", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Pacijent", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("BrojTelefona")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("nvarchar(20)");

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("date");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Napomene")
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id")
                        .HasName("PK__Pacijent__3214EC075A0E6AA8");

                    b.ToTable("Pacijenti", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Placanja", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<decimal>("Iznos")
                        .HasColumnType("decimal(10, 2)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

                    b.HasKey("Id")
                        .HasName("PK__Placanja__3214EC0781ED2050");

                    b.HasIndex("PacijentId");

                    b.ToTable("Placanja", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Recept", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("DoktorId")
                        .HasColumnType("int")
                        .HasColumnName("DoktorID");

                    b.Property<string>("Opis")
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

                    b.HasKey("Id")
                        .HasName("PK__Recepti__3214EC07612C3916");

                    b.HasIndex("DoktorId");

                    b.HasIndex("PacijentId");

                    b.ToTable("Recepti", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Termin", b =>
                {
                    b.Property<int>("TerminId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("TerminID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("TerminId"));

                    b.Property<DateTime>("DatumVrijeme")
                        .HasColumnType("datetime");

                    b.Property<int>("DoktorId")
                        .HasColumnType("int")
                        .HasColumnName("DoktorID");

                    b.Property<string>("Napomena")
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

                    b.Property<int>("UslugaId")
                        .HasColumnType("int")
                        .HasColumnName("UslugaID");

                    b.HasKey("TerminId")
                        .HasName("PK__Termini__42126CB53F850D3A");

                    b.HasIndex("DoktorId");

                    b.HasIndex("PacijentId");

                    b.HasIndex("UslugaId");

                    b.ToTable("Termini", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Usluga", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(10, 2)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.HasKey("Id")
                        .HasName("PK__Usluge__3214EC07FCE82835");

                    b.ToTable("Usluge", (string)null);
                });

            modelBuilder.Entity("eStomatologModel.Usluga", b =>
                {
                    b.HasOne("eStomatologServices.Database.VrstaUsluge", null)
                        .WithMany("Usluge")
                        .HasForeignKey("VrstaUslugeId");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktorOrdinacija", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Ordinacija", "Ordinacija")
                        .WithMany()
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");

                    b.Navigation("Ordinacija");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktoriSpecijalizacije", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany("DoktoriSpecijalizacije")
                        .HasForeignKey("DoktorId")
                        .IsRequired()
                        .HasConstraintName("FK_DoktoriSpecijalizacije_Doktori");

                    b.HasOne("eStomatologServices.Database.Specijalizacija", "Specijalizacija")
                        .WithMany("DoktoriSpecijalizacije")
                        .HasForeignKey("SpecijalizacijaId")
                        .IsRequired()
                        .HasConstraintName("FK_DoktoriSpecijalizacije_Specijalizacija");

                    b.Navigation("Doktor");

                    b.Navigation("Specijalizacija");
                });

            modelBuilder.Entity("eStomatologServices.Database.KorisniciUloge", b =>
                {
                    b.HasOne("eStomatologServices.Models.Korisnik", "Korisnik")
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("KorisnikId")
                        .IsRequired()
                        .HasConstraintName("FK_KorisniciUloge_Korisnici");

                    b.HasOne("eStomatologServices.Database.Uloge", "Uloga")
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("UlogaId")
                        .IsRequired()
                        .HasConstraintName("FK_KorisniciUloge_Uloge");

                    b.Navigation("Korisnik");

                    b.Navigation("Uloga");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ocjene", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Pacijent", "Pacijent")
                        .WithMany("Ocjene")
                        .HasForeignKey("PacijentId")
                        .IsRequired()
                        .HasConstraintName("FK_Ocjene_Pacijent");

                    b.Navigation("Doktor");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Models.Dijagnoza", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Pacijent", "Pacijent")
                        .WithMany("Dijagnozes")
                        .HasForeignKey("PacijentId")
                        .IsRequired()
                        .HasConstraintName("FK__Dijagnoze__Pacij__5441852A");

                    b.Navigation("Doktor");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Models.Doktor", b =>
                {
                    b.HasOne("eStomatologServices.Database.Grad", "Grad")
                        .WithMany("Doktori")
                        .HasForeignKey("GradId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Korisnik", "Korisnik")
                        .WithOne()
                        .HasForeignKey("eStomatologServices.Models.Doktor", "KorisnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Grad");

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("eStomatologServices.Models.Placanja", b =>
                {
                    b.HasOne("eStomatologServices.Models.Pacijent", "Pacijent")
                        .WithMany("Placanjas")
                        .HasForeignKey("PacijentId")
                        .IsRequired()
                        .HasConstraintName("FK__Placanja__Pacije__5BE2A6F2");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Models.Recept", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Pacijent", "Pacijent")
                        .WithMany("Receptis")
                        .HasForeignKey("PacijentId")
                        .IsRequired()
                        .HasConstraintName("FK__Recepti__Pacijen__5812160E");

                    b.Navigation("Doktor");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Models.Termin", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Pacijent", "Pacijent")
                        .WithMany("Terminis")
                        .HasForeignKey("PacijentId")
                        .IsRequired()
                        .HasConstraintName("FK__Termini__Pacijen__4F7CD00D");

                    b.HasOne("eStomatologServices.Models.Usluga", "Usluga")
                        .WithMany("Terminis")
                        .HasForeignKey("UslugaId")
                        .IsRequired()
                        .HasConstraintName("FK__Termini__UslugaI__5165187F");

                    b.Navigation("Doktor");

                    b.Navigation("Pacijent");

                    b.Navigation("Usluga");
                });

            modelBuilder.Entity("eStomatologServices.Database.Grad", b =>
                {
                    b.Navigation("Doktori");
                });

            modelBuilder.Entity("eStomatologServices.Database.Specijalizacija", b =>
                {
                    b.Navigation("DoktoriSpecijalizacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.Uloge", b =>
                {
                    b.Navigation("KorisniciUloges");
                });

            modelBuilder.Entity("eStomatologServices.Database.VrstaUsluge", b =>
                {
                    b.Navigation("Usluge");
                });

            modelBuilder.Entity("eStomatologServices.Models.Doktor", b =>
                {
                    b.Navigation("DoktoriSpecijalizacije");
                });

            modelBuilder.Entity("eStomatologServices.Models.Korisnik", b =>
                {
                    b.Navigation("KorisniciUloges");
                });

            modelBuilder.Entity("eStomatologServices.Models.Pacijent", b =>
                {
                    b.Navigation("Dijagnozes");

                    b.Navigation("Ocjene");

                    b.Navigation("Placanjas");

                    b.Navigation("Receptis");

                    b.Navigation("Terminis");
                });

            modelBuilder.Entity("eStomatologServices.Models.Usluga", b =>
                {
                    b.Navigation("Terminis");
                });
#pragma warning restore 612, 618
        }
    }
}
