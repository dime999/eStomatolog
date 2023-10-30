class ClinicsModel {
  final String title;
  final String address;
  final String imageUrl;

  ClinicsModel(
      {required this.address, required this.imageUrl, required this.title});
}

List<ClinicsModel> clinics = [
  ClinicsModel(
      address: 'Mejdandzik 3 T8',
      imageUrl: 'assets/images/klinika1.jpg',
      title: 'Stomatoloska Ordinacija Cosa'),
  ClinicsModel(
      address: 'Crkvice 4A',
      imageUrl: 'assets/images/klinika2.jpg',
      title: 'Stomatoloska Ordinacija Adem'),
  ClinicsModel(
      address: 'Mokusnice',
      imageUrl: 'assets/images/klinika3.jpg',
      title: 'Stomatoloska Ordinacija Ensar'),
  ClinicsModel(
      address: 'Tetovo',
      imageUrl: 'assets/images/klinika1.jpg',
      title: 'Stomatoloska Ordinacija Lakoste'),
  ClinicsModel(
      address: 'Mejdandzik 3 T8',
      imageUrl: 'assets/images/klinika2.jpg',
      title: 'Stomatoloska Ordinacija Buro'),
];
