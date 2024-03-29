import 'dart:convert';

SignUpRequestModel signUpRequestModelFromJson(String str) =>
    SignUpRequestModel.fromJson(json.decode(str));

String signUpRequestModelToJson(SignUpRequestModel data) =>
    json.encode(data.toJson());

class SignUpRequestModel {
  final String? name;
  final String? email;
  final String? gender;
  final String? status;

  SignUpRequestModel({
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      SignUpRequestModel(
        name: json["name"],
        email: json["email"],
        gender: json["gender"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "gender": gender,
        "status": status,
      };
}
