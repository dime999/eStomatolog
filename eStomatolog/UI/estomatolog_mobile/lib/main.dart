import 'package:estomatolog_mobile/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/doktor_specijalizacije_provider.dart';
import 'package:estomatolog_mobile/providers/grad_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/korisnik_kartica_provider.dart';
import 'package:estomatolog_mobile/providers/login_provider.dart';
import 'package:estomatolog_mobile/providers/nalaz_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/poklon_bon_provider.dart';
import 'package:estomatolog_mobile/providers/rezervacija_provider.dart';
import 'package:estomatolog_mobile/providers/slika_provider.dart';
import 'package:estomatolog_mobile/providers/specijalizacija_provider.dart';
import 'package:estomatolog_mobile/providers/termin_provider.dart';
import 'package:estomatolog_mobile/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
      ChangeNotifierProvider(create: (_) => DoktorSpecijalizacijaProvider()),
      ChangeNotifierProvider(create: (_) => TerminProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikKarticaProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stomatolog',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
