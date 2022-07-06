import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff26384f),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 190,
          ),
        ),
      ),
    );
  }

  gotoHome() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed('/home');
    });
  }
}
