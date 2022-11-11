import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/model/sign_in.dart';
import 'package:as_traders_customer_entry/service/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  static Future<String?> getSalesLoginResponse(
      {required phone, required password}) async {
    try {
      var response = await HttpService.signIn(phone: phone, password: password);
      log(response.statusCode.toString());
      var result = "";
      var responseAsMap = json.decode(response.body);
      if (response.statusCode == 200) {
        if (responseAsMap["no_user"] == "USER NOT EXISTS") {
          return result = "USER NOT EXISTS";
        } else if (responseAsMap["status"] == 200) {
          SignInSuccessResponse signInSuccessResponse =
              signInSuccessResponseFromJson(response.body);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              "SALES_AGENT_ID", signInSuccessResponse.agentsInfo.salesAgentId);
          sharedPreferences.setString("SALES_AGENT_NAME",
              signInSuccessResponse.agentsInfo.salesAgentName);
          sharedPreferences.setString("SALES_AGENT_ADDRESS",
              signInSuccessResponse.agentsInfo.salesAgentAddress);
          sharedPreferences.setString("SALES_AGENT_PHONE_NUMBER",
              signInSuccessResponse.agentsInfo.salesAgentPhoneNumber);
          sharedPreferences.setString("isRegistered", "true");
          return result = "Success";
        }
        result = "Success";
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
