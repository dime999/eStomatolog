import 'package:estomatolog_admin/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/login_provider.dart';
import 'package:estomatolog_admin/providers/nalaz_provider.dart';
import 'package:estomatolog_admin/providers/ocjene_provider.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/providers/poklon_bon_provider.dart';
import 'package:estomatolog_admin/providers/rezervacija_provider.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:estomatolog_admin/providers/specijalizacija_provider.dart';
import 'package:estomatolog_admin/providers/termin_provider.dart';
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
      ChangeNotifierProvider(create: (_) => PacijentOrdinacijaProvider()),
      ChangeNotifierProvider(create: (_) => NalazProvider()),
      ChangeNotifierProvider(create: (_) => SlikaProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
      ChangeNotifierProvider(create: (_) => DoktorOrdinacijaProvider()),
      ChangeNotifierProvider(create: (_) => PoklonBonProvider()),
      ChangeNotifierProvider(create: (_) => OcjeneProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
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
