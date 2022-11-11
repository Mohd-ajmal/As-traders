import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/service/http_service.dart';

class DistrictRepo {
  static Future<List?> getSalesLoginResponse() async {
    try {
      var response = await HttpService.getDistrict();
      log(response.statusCode.toString());

      Map<String, dynamic> responseAsMap = json.decode(response.body);
      if (response.statusCode == 200) {
        List district = responseAsMap["districts_list"];
        log(district.toString());
        return district;
      } else {
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

class DistrictByAreaRepo {
  static Future<List?> getSalesLoginResponse({required district}) async {
    try {
      var response = await HttpService.getDistrictByArea(districtId: district);
      log(response.statusCode.toString());

      Map<String, dynamic> responseAsMap = json.decode(response.body);
      if (response.statusCode == 200) {
        List? area = responseAsMap["area_list"];
        log(area.toString());
        return area;
      } else {
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
