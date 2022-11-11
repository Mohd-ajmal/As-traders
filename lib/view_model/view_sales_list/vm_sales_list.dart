import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/constant/string.dart';
import 'package:as_traders_customer_entry/model/model_sales_list.dart';
import 'package:as_traders_customer_entry/repository/repo_sales_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VmSalesList extends ChangeNotifier {
  // -------------------------------------- variables --------------------------

  bool _isProgress = false;
  String? _error;
  List<CustomerList>? _customerList;

  // -------------------------------------- Getters ----------------------------

  bool get isProgress => _isProgress;
  String? get error => _error;
  List<CustomerList>? get customerList => _customerList;

  // -------------------------------------- Methods ----------------------------
  Future onGettingList() async {
    try {
      _isProgress = true;

      notifyListeners();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var salesId = sharedPreferences.getString(Strings.salesAgentId);
      var response =
          await SalesListRepo.getSalesLoginResponse(salesAgentId: salesId);
      log(response.toString());
      if (response == null) {
        _error = 'Something went wrong';

        log(_error!);
        notifyListeners();
      } else {
        log("success");
        _isProgress = false;
        _customerList = response.customerList;
        notifyListeners();
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        log(_error ?? "s");
        _error = 'Please check your Internet connction';
        _isProgress = false;
        notifyListeners();
      } else if (e is HttpException) {
        _error = 'Something went wrong while calling http';
        _isProgress = false;
        notifyListeners();
      } else if (e is FormatException) {
        _error = 'Please check URL formate and try again';
        _isProgress = false;
        notifyListeners();
      }
    }
  }
}
