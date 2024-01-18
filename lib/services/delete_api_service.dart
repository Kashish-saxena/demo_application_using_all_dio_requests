import 'dart:developer';

import 'package:dio/dio.dart';

class DeleteApiService {
  static final dio = Dio();
  static Future<bool> deleteUser(int userId) async {
    try {
      Response response = await dio.delete(
        'https://gorest.co.in/public/v2/users/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b',
          },
        ),
      );
      if (response.statusCode == 204) {
        log('User deleted successfully');
        return true;
      } else {
        log('Error response: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error in deleting user $e');
      return false;
    }
  }
}
