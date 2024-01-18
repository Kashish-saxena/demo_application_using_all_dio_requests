import 'dart:developer';

import 'package:api_project/models/signup_request_model.dart';
import 'package:dio/dio.dart';

class PostApiService {
  static Future<bool> postData(SignUpRequestModel signUpRequestModel) async {
    try {
      var dio = Dio();

      final response = await dio.post(
        "https://gorest.co.in/public/v2/users",
        data: signUpRequestModelToJson(signUpRequestModel),
        options: Options(headers: {
          "Authorization":
              "Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b"
        }),
      );
      if (response.statusCode == 201) {
        log("Request data is: ${response.data}");
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      log("Exception :: $e :: StackTrace :: $s");
      return false;
    }
  }
}
