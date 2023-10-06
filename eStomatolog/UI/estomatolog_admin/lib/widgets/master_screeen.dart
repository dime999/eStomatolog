import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  MasterScreenWidget({this.child, this.title, super.key});

  @override
  State<MasterScreenWidget> createState() => __MasterScreenWidgetState();
}

class __MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Dodaj novog korisnika"),
                onTap: () {
                  print("object");
                },
              )
            ],
          ),
        ),
        body: widget.child);
  }
}
