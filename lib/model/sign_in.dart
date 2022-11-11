import 'dart:convert';

SignInSuccessResponse signInSuccessResponseFromJson(String str) =>
    SignInSuccessResponse.fromJson(json.decode(str));

String signInSuccessResponseToJson(SignInSuccessResponse data) =>
    json.encode(data.toJson());

class SignInSuccessResponse {
  SignInSuccessResponse({
    required this.status,
    required this.agentsInfo,
  });

  int status;
  AgentsInfo agentsInfo;

  factory SignInSuccessResponse.fromJson(Map<String, dynamic> json) =>
      SignInSuccessResponse(
        status: json["status"],
        agentsInfo: AgentsInfo.fromJson(json["agents_info"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "agents_info": agentsInfo.toJson(),
      };
}

class AgentsInfo {
  AgentsInfo({
    required this.salesAgentId,
    required this.salesAgentName,
    required this.salesAgentAddress,
    required this.salesAgentPhoneNumber,
  });

  String salesAgentId;
  String salesAgentName;
  String salesAgentAddress;
  String salesAgentPhoneNumber;

  factory AgentsInfo.fromJson(Map<String, dynamic> json) => AgentsInfo(
        salesAgentId: json["SALES_AGENT_ID"],
        salesAgentName: json["SALES_AGENT_NAME"],
        salesAgentAddress: json["SALES_AGENT_ADDRESS"],
        salesAgentPhoneNumber: json["SALES_AGENT_PHONE_NUMBER"],
      );

  Map<String, dynamic> toJson() => {
        "SALES_AGENT_ID": salesAgentId,
        "SALES_AGENT_NAME": salesAgentName,
        "SALES_AGENT_ADDRESS": salesAgentAddress,
        "SALES_AGENT_PHONE_NUMBER": salesAgentPhoneNumber,
      };
}
