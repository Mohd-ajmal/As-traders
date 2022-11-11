import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:as_traders_customer_entry/constant/api_manager.dart';

class HttpService {
  static Future<http.Response> signIn(
      {required phone, required password}) async {
    http.Response response;
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.salesLogin);
    try {
      response = await http
          .post(url, body: {"phoneNumber": phone, "password": password});
    } catch (e) {
      rethrow;
    }
    return response;
  }

  // customer registeration
  static Future<int> customerRegistration(
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
    log("message");

    int statusCode = 0;
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.customerEntry);
    try {
      var stream = http.ByteStream(Stream.castFrom(customerImage.openRead()));

      var length = await customerImage.length();

      var uri = url;

      var request = http.MultipartRequest("POST", uri);

      var multipartFile = http.MultipartFile(
        "customerPhoto",
        stream,
        length,
        filename: basename(customerImage.path),
      );

      var header = {
        'Content-Type': 'multipart/form-data',
      };
      request.headers.addAll(header);
      request.files.add(multipartFile);
      log(firstName);
      request.fields["customerFirstName"] = firstName;
      request.fields["customerLastName"] = lastName;
      request.fields["customerphoneNumber"] = phoneNumber;
      request.fields["customerMail"] = mail;
      request.fields["customerAdharNo"] = aadharNumber;
      request.fields["customerDistrict"] = customerDistrict;
      request.fields["customerArea"] = customerArea;
      request.fields["customerAddress"] = customerAddress;
      request.fields["reg_by"] = reqBy;

      var response1 = await request.send();
      log(response1.statusCode.toString());

      response1.stream.transform(utf8.decoder).listen((value) {
        statusCode = response1.statusCode;
        log(statusCode.toString());
      });
    } catch (e) {
      rethrow;
    }
    return statusCode;
  }

  static Future<http.Response> updateCustomer(
      {required updateId,
      required firstName,
      required lastName,
      required phoneNumber,
      required mail,
      required aadharNumber,
      required customerDistrict,
      required customerArea,
      required customerAddress,
      required reqBy}) async {
    http.Response response;
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.updateCustomers);
    try {
      response = await http.post(url, body: {
        "cutomerUpdateId": updateId,
        "customerFirstNameUpdate": firstName,
        "customerLastNameUpdate": lastName,
        "customerPhoneNumberUpdate": phoneNumber,
        "customerEmailUpdate": mail,
        "customerAdharNumberUpdate": aadharNumber,
        "customerDistrictUpdate": customerDistrict,
        "customerUpdateArea": customerArea,
        "customerAddressUpdate": customerAddress,
        "salesAgentId": reqBy
      });
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<http.Response> getDistrict() async {
    http.Response response;
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.getDistrict);
    try {
      response = await http.get(url);
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<http.Response> getDistrictByArea({required districtId}) async {
    http.Response response;
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.getAreaByDistrict);
    try {
      response = await http.post(url, body: {"districtId": districtId});
    } catch (e) {
      rethrow;
    }
    return response;
  }

  static Future<http.Response> getSalesList({required salesAgentId}) async {
    http.Response response;
    log(salesAgentId);
    var url = Uri.parse(ApiManager.baseUrl + ApiManager.getSalesAgentEntryList);
    try {
      response = await http.post(url, body: {"salesAgentId": salesAgentId});
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
