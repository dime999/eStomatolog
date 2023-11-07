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

                    b.ToTable("DoktoriOrdinacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktorSlika", b =>
                {
                    b.Property<int>("DoktorId")
                        .HasColumnType("int");

                    b.Property<int>("SlikaId")
                        .HasColumnType("int");

                    b.HasKey("DoktorId", "SlikaId")
                        .HasName("PK_doktor_slika");

                    b.HasIndex("SlikaId");

                    b.ToTable("DoktorSlike");
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

            modelBuilder.Entity("eStomatologServices.Database.KorisnikKartica", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("BrojKartice")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Cvv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("DatumIsteka")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("KorisnikId")
                        .HasColumnType("int");

                    b.Property<string>("VrstaKartica")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id")
                        .HasName("PK_KorisnikKartica");

                    b.HasIndex("KorisnikId");

                    b.ToTable("KorisnikKartice", (string)null);
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

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("DoktorId");

                    b.HasIndex("PacijentId");

                    b.ToTable("Ocjene", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.OrdinacijaSlika", b =>
                {
                    b.Property<int>("OrdinacijaId")
                        .HasColumnType("int");

                    b.Property<int>("SlikaId")
                        .HasColumnType("int");

                    b.HasKey("OrdinacijaId", "SlikaId")
                        .HasName("PK_ordinacija_slika");

                    b.HasIndex("SlikaId");

                    b.ToTable("OrdinacijaSlike");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ordinacije", b =>
                {
                    b.Property<int>("OrdinacijaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("OrdinacijaId"));

                    b.Property<string>("Adresa")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("GradId")
                        .HasColumnType("int");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("OrdinacijaId");

                    b.HasIndex("GradId");

                    b.ToTable("Ordinacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.Pacijent", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("datetime2");

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

                    b.Property<string>("Telefon")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id")
                        .HasName("PK__Pacijenti__3214EC07B54830TE");

                    b.HasIndex("GradId");

                    b.HasIndex("KorisnikId")
                        .IsUnique();

                    b.ToTable("Pacijenti", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.PacijentOrdinacija", b =>
                {
                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.Property<int>("OrdinacijaId")
                        .HasColumnType("int");

                    b.HasKey("PacijentId", "OrdinacijaId");

                    b.HasIndex("OrdinacijaId");

                    b.ToTable("PacijentiOrdinacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.PoklonBon", b =>
                {
                    b.Property<int>("PoklonBonId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PoklonBonId"));

                    b.Property<string>("BrojKartice")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("CvcCvvKod")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("DatumIstekaKartice")
                        .HasColumnType("datetime2");

                    b.Property<string>("ImePrezimeKorisnikaKojiKoristi")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Iskoristeno")
                        .HasColumnType("bit");

                    b.Property<decimal>("IznosPlacanja")
                        .HasColumnType("decimal(18,2)");

                    b.Property<string>("Kod")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("OrdinacijaId")
                        .HasColumnType("int");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.Property<bool>("Placeno")
                        .HasColumnType("bit");

                    b.HasKey("PoklonBonId")
                        .HasName("PK_PoklonBon");

                    b.HasIndex("OrdinacijaId");

                    b.HasIndex("PacijentId");

                    b.ToTable("PoklonBoni", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Database.Rezervacija", b =>
                {
                    b.Property<int>("RezervacijaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("RezervacijaId"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<int>("DoktorId")
                        .HasColumnType("int");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("OrdinacijaId")
                        .HasColumnType("int");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.Property<int>("TerminId")
                        .HasColumnType("int");

                    b.HasKey("RezervacijaId")
                        .HasName("PK_Rezervacija");

                    b.HasIndex("DoktorId");

                    b.HasIndex("OrdinacijaId");

                    b.HasIndex("PacijentId");

                    b.HasIndex("TerminId");

                    b.ToTable("Rezervacije");
                });

            modelBuilder.Entity("eStomatologServices.Database.Slika", b =>
                {
                    b.Property<int>("SlikaId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("SlikaId"));

                    b.Property<string>("Path")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("SlikaId");

                    b.ToTable("Slike");
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

            modelBuilder.Entity("eStomatologServices.Models.Placanja", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Datum")
                        .HasColumnType("datetime");

                    b.Property<decimal>("Iznos")
                        .HasColumnType("decimal(10, 2)");

                    b.Property<int>("PacijentId")
                        .HasColumnType("int");

                    b.HasKey("Id")
                        .HasName("PK__Placanja__3214EC0781ED2050");

                    b.ToTable("Placanja", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Recept", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("PacijentID");

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
                        .HasColumnType("int");

                    b.HasKey("Id")
                        .HasName("PK__Recepti__3214EC07612C3916");

                    b.HasIndex("DoktorId");

                    b.ToTable("Recepti", (string)null);
                });

            modelBuilder.Entity("eStomatologServices.Models.Termin", b =>
                {
                    b.Property<int>("TerminId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("TerminId");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("TerminId"));

                    b.Property<DateTime>("Vrijeme")
                        .HasColumnType("datetime")
                        .HasColumnName("Vrijeme");

                    b.HasKey("TerminId")
                        .HasName("PK_Termini");

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
                        .WithMany("DoktorOrdinacije")
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Ordinacije", "Ordinacija")
                        .WithMany()
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");

                    b.Navigation("Ordinacija");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktorSlika", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Slika", "Slika")
                        .WithMany()
                        .HasForeignKey("SlikaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");

                    b.Navigation("Slika");
                });

            modelBuilder.Entity("eStomatologServices.Database.DoktoriSpecijalizacije", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany("DoktoriSpecijalizacije")
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Specijalizacija", "Specijalizacija")
                        .WithMany()
                        .HasForeignKey("SpecijalizacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

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

            modelBuilder.Entity("eStomatologServices.Database.KorisnikKartica", b =>
                {
                    b.HasOne("eStomatologServices.Models.Korisnik", "Korisnik")
                        .WithMany("KorisnikKartice")
                        .HasForeignKey("KorisnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ocjene", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany("Ocjene")
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Pacijent", "Pacijent")
                        .WithMany("Ocjene")
                        .HasForeignKey("PacijentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Database.OrdinacijaSlika", b =>
                {
                    b.HasOne("eStomatologServices.Database.Ordinacije", "Ordinacija")
                        .WithMany()
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Slika", "Slika")
                        .WithMany("OrdinacijaSlike")
                        .HasForeignKey("SlikaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ordinacija");

                    b.Navigation("Slika");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ordinacije", b =>
                {
                    b.HasOne("eStomatologServices.Database.Grad", "Grad")
                        .WithMany()
                        .HasForeignKey("GradId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Grad");
                });

            modelBuilder.Entity("eStomatologServices.Database.Pacijent", b =>
                {
                    b.HasOne("eStomatologServices.Database.Grad", "Grad")
                        .WithMany("Pacijenti")
                        .HasForeignKey("GradId")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Korisnik", "Korisnik")
                        .WithOne()
                        .HasForeignKey("eStomatologServices.Database.Pacijent", "KorisnikId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Grad");

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("eStomatologServices.Database.PacijentOrdinacija", b =>
                {
                    b.HasOne("eStomatologServices.Database.Ordinacije", "Ordinacija")
                        .WithMany()
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Pacijent", "Pacijnet")
                        .WithMany("PacijentOrdinacije")
                        .HasForeignKey("PacijentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ordinacija");

                    b.Navigation("Pacijnet");
                });

            modelBuilder.Entity("eStomatologServices.Database.PoklonBon", b =>
                {
                    b.HasOne("eStomatologServices.Database.Ordinacije", "Ordinacija")
                        .WithMany("PoklonBonovi")
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Pacijent", "Pacijent")
                        .WithMany("PoklonBonovi")
                        .HasForeignKey("PacijentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Ordinacija");

                    b.Navigation("Pacijent");
                });

            modelBuilder.Entity("eStomatologServices.Database.Rezervacija", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Ordinacije", "Ordinacija")
                        .WithMany()
                        .HasForeignKey("OrdinacijaId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Pacijent", "Pacijent")
                        .WithMany()
                        .HasForeignKey("PacijentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Models.Termin", "Termin")
                        .WithMany()
                        .HasForeignKey("TerminId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");

                    b.Navigation("Ordinacija");

                    b.Navigation("Pacijent");

                    b.Navigation("Termin");
                });

            modelBuilder.Entity("eStomatologServices.Models.Dijagnoza", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("eStomatologServices.Database.Pacijent", "Pacijent")
                        .WithMany()
                        .HasForeignKey("PacijentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

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

            modelBuilder.Entity("eStomatologServices.Models.Recept", b =>
                {
                    b.HasOne("eStomatologServices.Models.Doktor", "Doktor")
                        .WithMany()
                        .HasForeignKey("DoktorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Doktor");
                });

            modelBuilder.Entity("eStomatologServices.Database.Grad", b =>
                {
                    b.Navigation("Doktori");

                    b.Navigation("Pacijenti");
                });

            modelBuilder.Entity("eStomatologServices.Database.Ordinacije", b =>
                {
                    b.Navigation("PoklonBonovi");
                });

            modelBuilder.Entity("eStomatologServices.Database.Pacijent", b =>
                {
                    b.Navigation("Ocjene");

                    b.Navigation("PacijentOrdinacije");

                    b.Navigation("PoklonBonovi");
                });

            modelBuilder.Entity("eStomatologServices.Database.Slika", b =>
                {
                    b.Navigation("OrdinacijaSlike");
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
                    b.Navigation("DoktorOrdinacije");

                    b.Navigation("DoktoriSpecijalizacije");

                    b.Navigation("Ocjene");
                });

            modelBuilder.Entity("eStomatologServices.Models.Korisnik", b =>
                {
                    b.Navigation("KorisniciUloges");

                    b.Navigation("KorisnikKartice");
                });
#pragma warning restore 612, 618
        }
    }
}
