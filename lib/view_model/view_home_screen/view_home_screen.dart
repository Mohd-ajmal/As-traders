import 'dart:developer';
import 'dart:io';

import 'package:as_traders_customer_entry/constant/string.dart';
import 'package:as_traders_customer_entry/repository/get_district.dart';
import 'package:as_traders_customer_entry/repository/registrationrepo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewHomeScreen extends ChangeNotifier {
  // ---------------------------------- variables ------------------------------
  File? _image;
  bool _isProgress = false;
  String? _error;
  String? districtValue;
  List? _districts;
  List? area;
  String? areaValue;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController audhaarController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // ---------------------------------- getters --------------------------------
  File? get image => _image;
  bool get isProgress => _isProgress;
  String? get error => _error;
  List? get district => _districts;
  //List? get area => _area;

  List<DropdownMenuItem<String>>? get districtDropDown {
    return _districts?.map((e) {
      return DropdownMenuItem(
          child: Text(e['DISTRICT_NAME']), value: e['DISTRICT_ID'].toString());
    }).toList();
  }

  List<DropdownMenuItem<String>>? get areaDropDown {
    return area?.map((e) {
      return DropdownMenuItem(
          child: Text(e['AREA_NAME']), value: e['AREA_ID'].toString());
    }).toList();
  }

  // ---------------------------------- methods --------------------------------
  imageFromCamera() async {
    try {
      ImagePicker _picker = ImagePicker();
      var imageFromCamera = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 1,
      );
      if (imageFromCamera == null) {
        log("image is null");
        return;
      }

      _image = File(imageFromCamera.path);
      log(_image!.path);
      notifyListeners();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future onCustomerEntry(
      {required File customerImage,
      required firstName,
      required lastName,
      required phoneNumber,
      required mail,
      required aadharNumber,
      required customerDistrict,
      required customerArea,
      required customerAddress,
      required reqBy,
      required context}) async {
    try {
      _isProgress = true;
      notifyListeners();

      var response = await RegistrationRepo.getRegistrationResponse(
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
      log(response.toString());
      if (response == null) {
        _error = 'Something went wrong';
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_error!)));
      } else {
        _error = response;
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_error!),
        ));
      }
    } on Exception catch (e) {
      log(e.toString());
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

  Future onGetDistrictResponse() async {
    try {
      _isProgress = true;
      notifyListeners();

      var response = await DistrictRepo.getSalesLoginResponse();
      log(response.toString());
      if (response == null) {
        _error = 'Something went wrong';
        notifyListeners();
      } else {
        _districts = response;
        _isProgress = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        log(e.message);
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

  Future onGetDistrictByAreaResponse({required district, context}) async {
    try {
      _isProgress = true;
      notifyListeners();

      var response =
          await DistrictByAreaRepo.getSalesLoginResponse(district: district);
      log(response.toString());
      if (response == null) {
        _error = 'Something went wrong';
        _isProgress = false;
        notifyListeners();
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No Area In Selected District")));
      } else {
        area = response;
        _isProgress = false;
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

  validation(context) async {
    // _isProgress = true;
    // notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var agentId = sharedPreferences.getString(Strings.salesAgentId);
    if (firstNameController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("First name can't be empty")));
    } else if (lastNameController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Last name can't be empty")));
    } else if (phoneNumberController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Phone number can't be empty")));
    } else if (image == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image can't be empty")));
    } else if (districtValue == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Choose district")));
    } else if (areaValue == null) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Choose area")));
    } else if (addressController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address can't be empty")));
    } else {
      onCustomerEntry(
          customerImage: image!,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneNumberController.text,
          mail: emailController.text,
          aadharNumber: audhaarController.text,
          customerDistrict: districtValue,
          customerArea: areaValue,
          customerAddress: addressController.text,
          reqBy: agentId,
          context: context);
    }
  }
}
