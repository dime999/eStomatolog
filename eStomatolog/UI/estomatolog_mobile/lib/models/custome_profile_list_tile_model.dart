import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile {
  final IconData icon;
  final String title;
  final bool isLogOut;
  CustomListTile({
    required this.icon,
    required this.title,
    required this.isLogOut,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.person_2,
    title: "Informacije profila",
    isLogOut: false,
  ),
  CustomListTile(
    icon: Icons.history,
    title: "Rezervaacije",
    isLogOut: false,
  ),
  CustomListTile(
    icon: Icons.book_outlined,
    title: "Karton",
    isLogOut: false,
  ),
  CustomListTile(
    icon: Icons.credit_card,
    title: "Nacin placanja",
    isLogOut: false,
  ),
  CustomListTile(
    icon: Icons.card_giftcard,
    title: "Poklon bonovi",
    isLogOut: false,
  ),
  CustomListTile(
    title: "Odjava",
    icon: CupertinoIcons.arrow_right_arrow_left,
    isLogOut: true,
  ),
];
