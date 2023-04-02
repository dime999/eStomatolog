using System;
using System.Collections.Generic;
using eStomatologServices.Database;
using eStomatologServices.Models;
using Microsoft.EntityFrameworkCore;

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

    public virtual DbSet<Ordinacija> Ordinacija { get; set; }

    public virtual DbSet<VrstaUsluge> VrstaUsluge { get; set; } = null!;
    



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

            entity.HasOne(d => d.Doktor).WithMany(p => p.Dijagnozes)
                .HasForeignKey(d => d.DoktorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Dijagnoze__Dokto__5535A963");

            entity.HasOne(d => d.Pacijent).WithMany(p => p.Dijagnozes)
                .HasForeignKey(d => d.PacijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Dijagnoze__Pacij__5441852A");
        });

        modelBuilder.Entity<Doktor>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Doktori__3214EC07B54830FE");

            entity.ToTable("Doktori");

            entity.Property(e => e.Ime).HasMaxLength(50);
            entity.Property(e => e.Prezime).HasMaxLength(50);
            entity.Property(e => e.Specijalnost).HasMaxLength(50);
        });

        modelBuilder.Entity<Pacijent>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Pacijent__3214EC075A0E6AA8");

            entity.ToTable("Pacijenti");

            entity.Property(e => e.Adresa).HasMaxLength(100);
            entity.Property(e => e.BrojTelefona).HasMaxLength(20);
            entity.Property(e => e.DatumRodjenja).HasColumnType("date");
            entity.Property(e => e.Email).HasMaxLength(50);
            entity.Property(e => e.Ime).HasMaxLength(50);
            entity.Property(e => e.Napomene).HasMaxLength(200);
            entity.Property(e => e.Prezime).HasMaxLength(50);
        });

        modelBuilder.Entity<Placanja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Placanja__3214EC0781ED2050");

            entity.ToTable("Placanja");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.Iznos).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.PacijentId).HasColumnName("PacijentID");

            entity.HasOne(d => d.Pacijent).WithMany(p => p.Placanjas)
                .HasForeignKey(d => d.PacijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Placanja__Pacije__5BE2A6F2");
        });

        modelBuilder.Entity<Recept>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Recepti__3214EC07612C3916");

            entity.ToTable("Recepti");

            entity.Property(e => e.Datum).HasColumnType("datetime");
            entity.Property(e => e.DoktorId).HasColumnName("DoktorID");
            entity.Property(e => e.Opis).HasMaxLength(200);
            entity.Property(e => e.PacijentId).HasColumnName("PacijentID");

            entity.HasOne(d => d.Doktor).WithMany(p => p.Receptis)
                .HasForeignKey(d => d.DoktorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Recepti__DoktorI__59063A47");

            entity.HasOne(d => d.Pacijent).WithMany(p => p.Receptis)
                .HasForeignKey(d => d.PacijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Recepti__Pacijen__5812160E");
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

            entity.HasOne(d => d.Doktor).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.DoktorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Termini__DoktorI__5070F446"); 

            entity.HasOne(d => d.Pacijent).WithMany(p => p.Terminis)
                .HasForeignKey(d => d.PacijentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Termini__Pacijen__4F7CD00D");

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

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
