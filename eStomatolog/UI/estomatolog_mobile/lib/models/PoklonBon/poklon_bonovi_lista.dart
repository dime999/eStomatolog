class PoklonBonoviLista {
  final String naziv;
  final String cijena;
  final String imageUrl;

  PoklonBonoviLista(
      {required this.naziv, required this.cijena, required this.imageUrl});
}

List<PoklonBonoviLista> bonovi = [
  PoklonBonoviLista(
      naziv: 'POKLON BON', imageUrl: 'assets/images/bon1.png', cijena: '30 KM'),
  PoklonBonoviLista(
      naziv: 'POKLON BON', imageUrl: 'assets/images/bon2.png', cijena: '50 KM'),
  PoklonBonoviLista(
      naziv: 'POKLON BON',
      imageUrl: 'assets/images/bon3.png',
      cijena: '100 KM'),
];
