import 'dart:async';

import 'package:estomatolog_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessReservatioScreen extends StatefulWidget {
  final int korisnikId;
  const SuccessReservatioScreen({required this.korisnikId, super.key});

  @override
  State<SuccessReservatioScreen> createState() =>
      _SuccessReservatioScreenState();
}

class _SuccessReservatioScreenState extends State<SuccessReservatioScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(
            korisnikId: widget.korisnikId,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/success.json',
                repeat: true, height: 200, width: double.infinity),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Uspješno ste napravili rezeraviju!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
