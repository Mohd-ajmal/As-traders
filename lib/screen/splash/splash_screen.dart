import 'dart:async';

import 'package:flutter/material.dart';

import 'package:as_traders_customer_entry/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animationController.repeat();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RouteManager.signInRoute, (route) => false));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "1",
              child: Container(
                height: 150.0,
                width: 150.0,
                alignment: Alignment.center,
                child: RotationTransition(
                  child: Image.asset("assets/images/asTraders.png"),
                  turns: _animationController,
                ),
              ),
            ),
            const Text(
              "As-Traders",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
