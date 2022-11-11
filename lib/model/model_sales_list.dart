import 'dart:convert';

SalesListModel salesListFromJson(String str) =>
    SalesListModel.fromJson(json.decode(str));

String salesListToJson(SalesListModel data) => json.encode(data.toJson());

class SalesListModel {
  SalesListModel({
    required this.status,
    required this.customerList,
  });

  int status;
  List<CustomerList> customerList;

  factory SalesListModel.fromJson(Map<String, dynamic> json) => SalesListModel(
        status: json["status"],
        customerList: List<CustomerList>.from(
            json["customer_list"].map((x) => CustomerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "customer_list":
            List<dynamic>.from(customerList.map((x) => x.toJson())),
      };
}

class CustomerList {
  CustomerList(
      {required this.customerId,
      required this.customerFirstName,
      required this.customerLastName,
      required this.customerPhoneNumber,
      this.customerEmail,
      this.customerAdharNo,
      this.customerDistrict,
      required this.customerCity,
      this.customerAddress,
      this.customerRemark,
      this.customerStatus,
      this.customerImage,
      required this.regBy,
      this.customerImageUrl,
      required this.districtName,
      required this.areaName});

  String customerId;
  String customerFirstName;
  String customerLastName;
  String customerPhoneNumber;
  String? customerEmail;
  String? customerAdharNo;
  String? customerDistrict;
  String customerCity;
  String? customerAddress;
  String? customerRemark;
  String? customerStatus;
  String? customerImage;
  String regBy;
  String? customerImageUrl;
  String? districtName;
  String? areaName;

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
      customerId: json["CUSTOMER_ID"],
      customerFirstName: json["CUSTOMER_FIRST_NAME"],
      customerLastName: json["CUSTOMER_LAST_NAME"],
      customerPhoneNumber: json["CUSTOMER_PHONE_NUMBER"],
      customerEmail: json["CUSTOMER_EMAIL"],
      customerAdharNo: json["CUSTOMER_ADHAR_NO"],
      customerDistrict: json["CUSTOMER_DISTRICT"],
      districtName: json["DISTRICT_NAME"],
      customerCity: json["CUSTOMER_CITY"],
      customerAddress: json["CUSTOMER_ADDRESS"],
      customerRemark: json["CUSTOMER_REMARK"],
      customerStatus: json["CUSTOMER_STATUS"],
      customerImage: json["CUSTOMER_IMAGE"],
      regBy: json["reg_by"],
      customerImageUrl: json["CUSTOMER_IMAGE_URL"],
      areaName: json["AREA_NAME"]);

  Map<String, dynamic> toJson() => {
        "CUSTOMER_ID": customerId,
        "CUSTOMER_FIRST_NAME": customerFirstName,
        "CUSTOMER_LAST_NAME": customerLastName,
        "CUSTOMER_PHONE_NUMBER": customerPhoneNumber,
        "CUSTOMER_EMAIL": customerEmail,
        "CUSTOMER_ADHAR_NO": customerAdharNo,
        "CUSTOMER_DISTRICT": customerDistrict,
        "CUSTOMER_CITY": customerCity,
        "CUSTOMER_ADDRESS": customerAddress,
        "CUSTOMER_REMARK": customerRemark,
        "CUSTOMER_STATUS": customerStatus,
        "CUSTOMER_IMAGE": customerImage,
        "reg_by": regBy,
      };
}
