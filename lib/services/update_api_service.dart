import 'dart:developer';
import 'package:api_project/models/signup_request_model.dart';
import 'package:dio/dio.dart';

class UpdateApiService {
  static Future<bool> updateUser(
      int id, SignUpRequestModel signUpRequestModel) async {
    try {
      var dio = Dio();
      final response = await dio.put(
        "https://gorest.co.in/public/v2/users/$id",
        data: signUpRequestModelToJson(signUpRequestModel),
        options: Options(headers: {
          'Content-Type': 'application/json',
          "Authorization":
              "Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b"
        }),
      );
      if (response.statusCode == 200) {
        log("Updated user deatails: ${response.data}");
        return true;
      } else {
        log("Failed to load data is: ");
        return false;
      }
    } catch (e) {
      log("Exception $e");
      return false;
    }
  }

  //  static Future<void> updateUser(int id) async {
  //   try {
  //     var dio = Dio();
  //     final response = await dio.put(
  //       "https://gorest.co.in/public/v2/users/$id",
  //       data: {'name': "test", 'email': "test@145234",'gender':"female",'status':"inactive"},
  //       options: Options(headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         "Authorization":
  //             "Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b"
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       log("Updated user deatails: ${response.data}");
  //     } else {
  //       log("Failed to load data is: ");
  //     }
  //   } catch (e) {
  //     log("Exception $e");
  //   }
  // }
}
