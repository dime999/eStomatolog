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
    icon: Icons.history,
    title: "Informacije profila",
    isLogOut: false,
  ),
  CustomListTile(
    icon: Icons.history,
    title: "Historija rezervacija",
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
    title: "Odjava",
    icon: CupertinoIcons.arrow_right_arrow_left,
    isLogOut: true,
  ),
];
