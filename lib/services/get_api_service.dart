import 'dart:developer';
import 'package:api_project/models/signup_response_model.dart';
import 'package:dio/dio.dart';
class GetApiService {
  static Dio dio = Dio();

  static Future<List<SignUpResponseModel>> getData() async {
    List<SignUpResponseModel> userList = [];
    try {
      Response response = await dio.get(
        "https://gorest.co.in/public/v2/users",
        options: Options(
          headers: {
            'Content-Type': "application/json",
            "Authorization":
                "Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b",
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> userData = response.data;
        for (var i = 0; i < userData.length; i++) {
          SignUpResponseModel signUpResponseModel = SignUpResponseModel(
            email: userData[i]['email'],
            gender: userData[i]['gender'],
            id: userData[i]['id'],
            name: userData[i]['name'],
            status: userData[i]['status'],
          );
          userList.add(signUpResponseModel);
        }
      } else {
        log('Error response: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching data $e');
    }
    return userList;
  }

  static Future<SignUpResponseModel?> getUserDetails(int userId) async {
    try {
      Response response = await dio.get(
        'https://gorest.co.in/public/v2/users/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b',
          },
        ),
      );

      if (response.statusCode == 200) {
        return SignUpResponseModel.fromJson(response.data);
      } else {
        log('Error getting user details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error getting user details: $e');
      return null;
    }
  }
}
