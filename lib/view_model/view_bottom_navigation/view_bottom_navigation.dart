import 'package:as_traders_customer_entry/routes/routes.dart';
import 'package:as_traders_customer_entry/screen/home/home_screen.dart';
import 'package:as_traders_customer_entry/screen/sales_agent_list/sales_list.dart';
import 'package:as_traders_customer_entry/view_model/view_home_screen/view_home_screen.dart';
import 'package:as_traders_customer_entry/view_model/view_sales_list/vm_sales_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VmBottomNavigation extends ChangeNotifier {
  // ----------------------------------- Getters -------------------------------
  int get selectedIndex => _selectedIndex;

  // ---------------------------------- Variables ------------------------------

  int _selectedIndex = 0;

  // ---------------------------------- Methods --------------------------------

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onLogout({required context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, RouteManager.initialRoute, (route) => false);
    notifyListeners();
  }

  getBody({required context}) {
    switch (_selectedIndex) {
      case 0:
        return Center(
          child: ChangeNotifierProvider(
              create: (BuildContext context) => ViewHomeScreen(),
              child: const HomePage()),
        );
      case 1:
        return Center(
          child: ChangeNotifierProvider(
              create: (BuildContext context) => VmSalesList(),
              child: const SalesList()),
        );
      default:
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Would you like to Logout?"),
          actions: [
            ElevatedButton(
              onPressed: () => onLogout(context: context),
              child: const Text("Logout"),
            ),
            TextButton(
                onPressed: () {
                  _selectedIndex = 1;
                  notifyListeners();
                },
                child: const Text("Cancel")),
          ],
        );
    }
  }
}
