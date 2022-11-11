import 'package:flutter/material.dart';

import 'package:as_traders_customer_entry/routes/routes.dart';
import 'package:as_traders_customer_entry/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'As-Traders',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: (settings) => RouteManager.generateRoute(settings),
    );
  }
}
