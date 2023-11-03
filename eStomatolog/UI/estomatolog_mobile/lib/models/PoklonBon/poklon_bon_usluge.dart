class PoklonBonUsluga {
  final String naziv;
  final String opis;
  final int cijena;

  PoklonBonUsluga(
      {required this.naziv, required this.opis, required this.cijena});
}

List<PoklonBonUsluga> bonoviUsluge = [
  PoklonBonUsluga(
      naziv: 'Pregled',
      opis:
          'Naši doktori će vam pregledati stanje zuba u donjoj i gornjoj vilici, dati preporuke za oralnu higijenu ili eventualnu intervenciju i saniranje problema.',
      cijena: 30),
  PoklonBonUsluga(
      naziv: 'Popravka zuba',
      opis:
          'Popravku zuba podrazumijeva saniranje područja zahvaćenog karijesom i stavljanje privremene/stalne plombe.',
      cijena: 30),
  PoklonBonUsluga(
      naziv: 'Ekstrakcija zuba',
      opis:
          'Ekstrakcija zuba iz gornje ili donje vilice (U OVU USLUGU NE SPADA EXSTRAKCIJA MOLARA).',
      cijena: 50),
  PoklonBonUsluga(
      naziv: 'Izbjeljivanje zuba',
      opis: 'Estetski zahvat koji će izbijeliti vaše zube.',
      cijena: 100)
];
