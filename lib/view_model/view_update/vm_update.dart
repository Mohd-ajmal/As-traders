import 'dart:convert';
import 'dart:io';

import 'package:as_traders_customer_entry/repository/update_repo.dart';
import 'package:flutter/material.dart';

class VmUpdate extends ChangeNotifier {
  // ---------------------------------- Variables ------------------------------
  var updateFN = TextEditingController();
  var updateLN = TextEditingController();
  String? _error;
  bool _isProgress = false;

  // ---------------------------------- Getters --------------------------------

  bool get isProgress => _isProgress;
  String? get error => _error;

  // ---------------------------------- Methods --------------------------------

  Future onUpdateResponse(
      {required context,
      required id,
      required firstName,
      required lastName,
      required phoneNumber,
      required mail,
      required aadharNumber,
      required customerDistrict,
      required customerArea,
      required customerAddress,
      required reqBy}) async {
    try {
      _isProgress = true;
      notifyListeners();

      var response = await UpdateRepo.getUpdateResponse(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          mail: mail,
          aadharNumber: aadharNumber,
          customerDistrict: customerDistrict,
          customerArea: customerArea,
          customerAddress: customerAddress,
          reqBy: reqBy);
      if (response == null) {
        _error = 'Something went wrong';
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      } else {
        var map = json.decode(response.body);
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(map["message"]),
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
      }
    }
  }
}
