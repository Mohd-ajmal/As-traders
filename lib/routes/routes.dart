import 'package:as_traders_customer_entry/screen/bottom_navigation/bottom_navigaton.dart';
import 'package:as_traders_customer_entry/view_model/view_bottom_navigation/view_bottom_navigation.dart';
import 'package:as_traders_customer_entry/view_model/view_home_screen/view_home_screen.dart';
import 'package:as_traders_customer_entry/view_model/vm_signin/vm_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:as_traders_customer_entry/screen/sign_in/sign_in_screen.dart';
import 'package:as_traders_customer_entry/screen/home/home_screen.dart';
import 'package:as_traders_customer_entry/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class RouteManager {
  static const String initialRoute = "/";
  static const String signInRoute = "/signIn";
  static const String bottomNavigation = "/bottomNavigation";
  static const String homeRoute = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case signInRoute:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => VmSignIn(),
                child: const SignInScreen()));
      case homeRoute:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => ViewHomeScreen(),
                child: const HomePage()));
      case bottomNavigation:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => VmBottomNavigation(),
                child: const BottomNavigationScreen()));
      default:
        throw const FormatException("Route not found please check route name");
    }
  }
}
