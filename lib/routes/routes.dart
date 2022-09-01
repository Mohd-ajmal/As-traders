import 'package:flutter/material.dart';

import 'package:as_traders_customer_entry/screen/sign_in/sign_in_screen.dart';
import 'package:as_traders_customer_entry/main.dart';
import 'package:as_traders_customer_entry/screen/splash/splash_screen.dart';

class RouteManager {
  static const String initialRoute = "/";
  static const String signInRoute = "/signIn";
  static const String homeRoute = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case signInRoute:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case homeRoute:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: ""));
      default:
        throw const FormatException("Route not found please check route name");
    }
  }
}
