﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using eStomatologServices;

#nullable disable

namespace eStomatologServices.Migrations
{
    [DbContext(typeof(eStomatologContext))]
    [Migration("20230427213017_ini")]
    partial class ini
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
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

            modelBuilder.Entity("eStomatologServices.Database.KorisniciUloge", b =>
                {
                    b.Property<int>("KorisniciUlogeID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisniciUlogeID"));

                    b.Property<DateTime>("DatumIzmjene")
                        .HasColumnType("datetime2");

                    b.Property<int>("KorisnikID")
                        .HasColumnType("int");

                    b.Property<int>("UlogaID")
                        .HasColumnType("int");

                    b.Property<int?>("UlogeUlogaId")
                        .HasColumnType("int");

                    b.HasKey("KorisniciUlogeID");

                    b.HasIndex("KorisnikID");

                    b.HasIndex("UlogeUlogaId");

                    b.ToTable("KorisnikUloge");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ordinacija", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

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

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Ordinacija");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Adresa = "Crkvice 40",
                            Drzava = "Bosna i Hercegovina",
                            Grad = "Zenica",
                            Naziv = "Ordinacija 1",
                            Telefon = "061111111"
                        },
                        new
                        {
                            Id = 2,
                            Adresa = "Hamida Vuka 41",
                            Drzava = "Bosna i Hercegovina",
                            Grad = "Mostar",
                            Naziv = "Ordinacija 2",
                            Telefon = "061111112"
                        });
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

                    b.HasData(
                        new
                        {
                            VrstaUslugeId = 1,
                            Naziv = "Redovno cišcenje zuba"
                        },
                        new
                        {
                            VrstaUslugeId = 2,
                            Naziv = "Popravka karijesa"
                        },
                        new
                        {
                            VrstaUslugeId = 3,
                            Naziv = "Izbeljivanje zuba pomocu gela"
                        });
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

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int?>("OrdinacijaId")
                        .HasColumnType("int");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Specijalnost")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id")
                        .HasName("PK__Doktori__3214EC07B54830FE");

                    b.HasIndex("OrdinacijaId");

                    b.ToTable("Doktori", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Korisnik", b =>
                {
                    b.Property<int>("KorisnikId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("KorisnikId"));

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("KorisnickoIme")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaHash")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("LozinkaSalt")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool?>("Status")
                        .HasColumnType("bit");

                    b.Property<string>("Telefon")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("KorisnikId");

                    b.ToTable("Korisnik");
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

            modelBuilder.Entity("eStomatologServices.Database.KorisniciUloge", b =>
                {
                    b.HasOne("eStomatologServices.Models.Korisnik", null)
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("KorisnikID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Uloge", null)
                        .WithMany("KorisniciUloges")
                        .HasForeignKey("UlogeUlogaId");
                });

            modelBuilder.Entity("eStomatologServices.Models.Dijagnoza", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany("Dijagnozes")
                        .HasForeignKey("DoktorId")
                        .IsRequired()
                        .HasConstraintName("FK__Dijagnoze__Dokto__5535A963");

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
                    b.HasOne("eStomatologServices.Database.Ordinacija", null)
                        .WithMany("Doktori")
                        .HasForeignKey("OrdinacijaId");
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
                        .WithMany("Receptis")
                        .HasForeignKey("DoktorId")
                        .IsRequired()
                        .HasConstraintName("FK__Recepti__DoktorI__59063A47");

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
                        .WithMany("Terminis")
                        .HasForeignKey("DoktorId")
                        .IsRequired()
                        .HasConstraintName("FK__Termini__DoktorI__5070F446");

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

            modelBuilder.Entity("eStomatologServices.Database.Ordinacija", b =>
                {
                    b.Navigation("Doktori");
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
                    b.Navigation("Dijagnozes");

                    b.Navigation("Receptis");

                    b.Navigation("Terminis");
                });

            modelBuilder.Entity("eStomatologServices.Models.Korisnik", b =>
                {
                    b.Navigation("KorisniciUloges");
                });

            modelBuilder.Entity("eStomatologServices.Models.Pacijent", b =>
                {
                    b.Navigation("Dijagnozes");

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