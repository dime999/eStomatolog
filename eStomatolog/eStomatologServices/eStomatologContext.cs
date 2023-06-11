using System;
using System.Collections.Generic;
using eStomatologServices.Database;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Identity;

namespace eStomatologServices;

public partial class eStomatologContext : DbContext
{
    public eStomatologContext()
    {
    }

    public eStomatologContext(DbContextOptions<eStomatologContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Dijagnoza> Dijagnoze { get; set; }

    public virtual DbSet<Doktor> Doktori { get; set; }

    public virtual DbSet<Pacijent> Pacijenti { get; set; }

    public virtual DbSet<Placanja> Placanja { get; set; }

    public virtual DbSet<Recept> Recepti { get; set; }

    public virtual DbSet<Termin> Termini { get; set; }

    public virtual DbSet<Usluga> Usluge { get; set; }

    public virtual DbSet<Korisnik> Korisnik { get; set; }

    public virtual DbSet<Ordinacije> Ordinacija { get; set; }

    public virtual DbSet<VrstaUsluge> VrstaUsluge { get; set; } = null!;

    public virtual DbSet<Uloge> Uloge { get; set; }

    public virtual DbSet<Ocjene> Ocjene { get; set; }

    public virtual DbSet<Rezervacija> Rezervacije { get; set; }

    public virtual DbSet<KorisniciUloge> KorisnikUloge { get; set; }

    public virtual DbSet<Specijalizacija> Specijalizacije { get; set; }

    public virtual DbSet<Grad> Gradovi { get; set; }

    public virtual DbSet<Ordinacije> Ordinacije { get; set; }

    public virtual DbSet<DoktoriSpecijalizacije> DoktoriSpecijalizacije { get; set; }

    public virtual DbSet<DoktorOrdinacija> DoktoriOrdinacije{ get; set; }

    public virtual DbSet<PacijentOrdinacija> PacijentiOrdinacije{ get; set; }

    public virtual DbSet<Slika> Slike{ get; set; }

    public virtual DbSet<OrdinacijaSlika> OrdinacijaSlike{ get; set; }








    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Server=DESKTOP-G59MHAT\\SQLEXPRESS;Database=eStomatolog;Trusted_Connection=True;TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Dijagnoza>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Dijagnoz__3214EC07B6723559");

            entity.ToTable("Dijagnoze");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.DoktorId).HasColumnName("DoktorID");
            entity.Property(e => e.Opis).HasMaxLength(200);
            entity.Property(e => e.PacijentId).HasColumnName("PacijentID");

        });

        modelBuilder.Entity<Doktor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Doktori__3214EC07B54830FE");
            entity.HasOne(d => d.Korisnik)
            .WithOne()
            .HasForeignKey<Doktor>(d => d.KorisnikId);
            entity.ToTable("Doktori");


        });

        modelBuilder.Entity<Pacijent>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Pacijneti__3214EC07B54830TE");
            entity.HasOne(d => d.Korisnik)
            .WithOne()
            .HasForeignKey<Pacijent>(d => d.KorisnikId);
            entity.ToTable("Pacijenti");


        });


        

        modelBuilder.Entity<Pacijent>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Pacijenti__3214EC07B54830TE");

           
            entity.HasOne(d => d.Grad)
                .WithMany(g => g.Pacijenti)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.ToTable("Pacijenti");
        });



        modelBuilder.Entity<Grad>(entity =>
        {
            entity.HasKey(e => e.GradId);

            
            entity.HasMany(g => g.Doktori)
                .WithOne(d => d.Grad)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.Restrict);


            entity.HasMany(g => g.Pacijenti)
                .WithOne(d => d.Grad)
                .HasForeignKey(d => d.GradId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.ToTable("Gradovi");
        });

        modelBuilder.Entity<Grad>(entity =>
        {
            entity.HasKey(e => e.GradId);

            entity.ToTable("Gradovi");
        });





        modelBuilder.Entity<Placanja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Placanja__3214EC0781ED2050");

            entity.ToTable("Placanja");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.Iznos).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Id).HasColumnName("PacijentID");

        });

        modelBuilder.Entity<Recept>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Recepti__3214EC07612C3916");

            entity.ToTable("Recepti");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.DoktorId).HasColumnName("DoktorID");
            entity.Property(e => e.Opis).HasMaxLength(200);
            entity.Property(e => e.Id).HasColumnName("PacijentID");

        });

        modelBuilder.Entity<Termin>(entity =>
        {
            entity.HasKey(e => e.TerminId).HasName("PK__Termini__42126CB53F850D3A");

            entity.ToTable("Termini");

            entity.Property(e => e.TerminId).HasColumnName("TerminID");
            entity.Property(e => e.DatumVrijeme).HasColumnType("datetime");
            entity.Property(e => e.DoktorId).HasColumnName("DoktorID");
            entity.Property(e => e.Napomena).HasMaxLength(200);
            entity.Property(e => e.PacijentId).HasColumnName("PacijentID");
            entity.Property(e => e.UslugaId).HasColumnName("UslugaID");



          

            entity.HasOne(d => d.Usluga).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.UslugaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Termini__UslugaI__5165187F");
        });

        modelBuilder.Entity<Usluga>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Usluge__3214EC07FCE82835");

            entity.ToTable("Usluge");

            entity.Property(e => e.Cijena).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(200);
        });
        modelBuilder.Entity<VrstaUsluge>(entity =>
        {
            entity.HasKey(e => e.VrstaUslugeId);

            entity.Property(e => e.VrstaUslugeId).HasColumnName("VrstaUslugeId");

            entity.Property(e => e.Naziv).HasMaxLength(50);
        });
        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.UlogaId);

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.Property(e => e.Naziv).HasMaxLength(50);
            entity.Property(e => e.Opis).HasMaxLength(200);
        });
        modelBuilder.Entity<Korisnik>(entity =>
        {
            entity.HasKey(e => e.KorisnikId);

            entity.ToTable("Korisnik");

            entity.HasIndex(e => e.Email, "CS_Email")
                .IsUnique();

            entity.HasIndex(e => e.KorisnickoIme, "CS_KorisnickoIme")
                .IsUnique();

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.Property(e => e.Email).HasMaxLength(100);

            entity.Property(e => e.Ime).HasMaxLength(50);

            entity.Property(e => e.KorisnickoIme).HasMaxLength(50);

            entity.Property(e => e.LozinkaHash).HasMaxLength(50);

            entity.Property(e => e.LozinkaSalt).HasMaxLength(50);

            entity.Property(e => e.Prezime).HasMaxLength(50);

            entity.Property(e => e.Status)
                .IsRequired()
                .HasDefaultValueSql("((1))");

            entity.Property(e => e.Telefon).HasMaxLength(20);
        });

        modelBuilder.Entity<KorisniciUloge>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogaId);

            entity.ToTable("KorisnikUloge");

            entity.Property(e => e.KorisnikUlogaId).HasColumnName("KorisnikUlogaID");

            entity.Property(e => e.DatumIzmjene).HasColumnType("datetime");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.HasOne(d => d.Korisnik)
                .WithMany(p => p.KorisniciUloges)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_KorisniciUloge_Korisnici");

            entity.HasOne(d => d.Uloga)
                .WithMany(p => p.KorisniciUloges)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_KorisniciUloge_Uloge");
        });

        modelBuilder.Entity<Ocjene>(entity =>
        {
            entity.HasKey(e => e.Id);

            entity.ToTable("Ocjene");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.Ocjena).IsRequired();

        });


        modelBuilder.Entity<DoktoriSpecijalizacije>(entity =>
        {
            entity.HasKey(e => e.DoktorSpecijalizacijaId);

            entity.ToTable("DoktoriSpecijalizacije");

            entity.Property(e => e.DoktorSpecijalizacijaId).HasColumnName("DoktorSpecijalizacijaId");


            entity.Property(e => e.DoktorId).HasColumnName("DoktorId");

            entity.Property(e => e.SpecijalizacijaId).HasColumnName("SpecijalizacijaId");

            
        });

        modelBuilder.Entity<DoktorOrdinacija>()
      .HasKey(d => new { d.DoktorId, d.OrdinacijaId});

        modelBuilder.Entity<PacijentOrdinacija>()
     .HasKey(d => new { d.PacijentId, d.OrdinacijaId });


        modelBuilder.Entity<Ordinacije>(entity =>
        {
            entity.HasKey(e => e.OrdinacijaId);

            entity.Property(e => e.Naziv).IsRequired();
            entity.Property(e => e.Adresa).IsRequired();
            entity.Property(e => e.Telefon).IsRequired();

        });


        modelBuilder.Entity<OrdinacijaSlika>(entity =>
        {
            entity.HasKey(k => new { k.OrdinacijaId, k.SlikaId })
                .HasName("PK_ordinacija_slika");
        });


    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
