import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/service/http_service.dart';

class RegistrationRepo {
  static Future<String?> getRegistrationResponse(
      {required File customerImage,
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
      var response = await HttpService.customerRegistration(
          customerImage: customerImage,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          mail: mail,
          aadharNumber: aadharNumber,
          customerDistrict: customerDistrict,
          customerArea: customerArea,
          customerAddress: customerAddress,
          reqBy: reqBy);

      var result = "";
      log(response.toString());
      if (response == 200) {
        log(response.toString());
        result = "Success";
        return result;
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
