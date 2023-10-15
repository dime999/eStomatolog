import 'package:estomatolog_admin/models/Pacijent/pacijent_ordinacija.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/providers/specijalizacija_provider.dart';
import 'package:estomatolog_admin/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => DoktorProvider()),
      ChangeNotifierProvider(create: (_) => PacijentProvider()),
      ChangeNotifierProvider(create: (_) => SpecijalizacijaProvider()),
      ChangeNotifierProvider(create: (_) => OrdinacijaProvider()),
      ChangeNotifierProvider(create: (_) => GradProvider()),
      ChangeNotifierProvider(create: (_) => PacijentOrdinacijaProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
