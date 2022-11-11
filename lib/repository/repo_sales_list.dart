import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/model/model_sales_list.dart';
import 'package:as_traders_customer_entry/service/http_service.dart';

class SalesListRepo {
  static Future<SalesListModel?> getSalesLoginResponse(
      {required salesAgentId}) async {
    try {
      var response = await HttpService.getSalesList(salesAgentId: salesAgentId);
      log(response.statusCode.toString());
      var result = salesListFromJson(response.body);
      log(response.body.toString());
      if (response.statusCode == 200) {
        log(result.toString());
        return result;
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
