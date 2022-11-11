import 'dart:io';

import 'package:as_traders_customer_entry/repository/loginrepo.dart';
import 'package:as_traders_customer_entry/routes/routes.dart';
import 'package:flutter/material.dart';

class VmSignIn extends ChangeNotifier {
  // ----------------------------- variables ----------------------------

  final _phone = TextEditingController();
  final _password = TextEditingController();
  String? _error;
  bool _isProgress = false;

  // ---------------------------- getters -------------------------------

  TextEditingController get phone => _phone;
  TextEditingController get password => _password;
  String? get error => _error;
  bool get isProgress => _isProgress;

  // ---------------------------- methods -------------------------------

  Future onGetResponse({required context}) async {
    try {
      _isProgress = true;
      notifyListeners();

      var response = await LoginRepo.getSalesLoginResponse(
          phone: phone.text, password: password.text);
      if (response == null) {
        _error = 'Something went wrong';
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      } else {
        _error = response;
        _isProgress = false;
        if (_error == "Success") {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteManager.bottomNavigation, (route) => false);
        }
        notifyListeners();
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_error!),
        ));
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        _error = 'Please check your Internet connction';
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      } else if (e is HttpException) {
        _error = 'Something went wrong while calling http';
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      } else if (e is FormatException) {
        _error = 'Please check URL formate and try again';
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      }
    }
  }
}
