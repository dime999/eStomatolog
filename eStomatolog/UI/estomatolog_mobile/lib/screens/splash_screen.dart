import 'package:estomatolog_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _simulateLoading().then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    });
  }

  Future<void> _simulateLoading() async {
    // Koristi Future.delayed za čekanje 3 sekunde
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'D  O  B  R  O  D  O  Š  L  I',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Arial'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 45,
                ),
                const CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 6.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
