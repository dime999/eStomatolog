class CustomListTile {
  final String imagePath;
  final String title;
  final bool isLogOut;
  CustomListTile({
    required this.imagePath,
    required this.title,
    required this.isLogOut,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    imagePath: 'assets/images/profile_info.png',
    title: "Informacije profila",
    isLogOut: false,
  ),
  CustomListTile(
    imagePath: 'assets/images/reservation.png',
    title: "Rezervacije",
    isLogOut: false,
  ),
  CustomListTile(
    imagePath: 'assets/images/nalaz.jpg',
    title: "Karton",
    isLogOut: false,
  ),
  CustomListTile(
    imagePath: 'assets/images/placanja.png',
    title: "Nacin placanja",
    isLogOut: false,
  ),
  CustomListTile(
    imagePath: 'assets/images/poklon.png',
    title: "Poklon bonovi",
    isLogOut: false,
  ),
  CustomListTile(
    imagePath: 'assets/images/recommended.png',
    title: "Preporučeni doktori",
    isLogOut: false,
  ),
  CustomListTile(
    title: "Odjavi se",
    imagePath: 'assets/images/logout.png',
    isLogOut: true,
  ),
];
