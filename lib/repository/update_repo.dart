import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/service/http_service.dart';
import 'package:http/http.dart';

class UpdateRepo {
  static Future<Response?> getUpdateResponse(
      {required id,
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
      var response = await HttpService.updateCustomer(
          updateId: id,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          mail: mail,
          aadharNumber: aadharNumber,
          customerDistrict: customerDistrict,
          customerArea: customerArea,
          customerAddress: customerAddress,
          reqBy: reqBy);

      log(response.toString());
      if (response.statusCode == 200) {
        log(response.body);

        return response;
      } else {
        log(response.toString());
        return null;
      }
    } on SocketException {
      rethrow;
    } on FormatException {
      rethrow;
    } on HttpException {
      rethrow;
    } on TimeoutException {
      rethrow;
    }
  }
}
