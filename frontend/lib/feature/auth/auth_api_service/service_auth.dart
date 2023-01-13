import 'package:dio/dio.dart';
import 'package:flutter_application_singkatin/helper/token_helper.dart';
import 'package:flutter_application_singkatin/helper/url_helper.dart';

class APIServiceAuthentication {
  final Dio _dio = Dio();
  final TokenHelper _tokenHelper = TokenHelper();

  Future<Response<dynamic>?> postLogin(String email, String password) async {
    try {
      final response = await _dio.post(
        '${UrlHelper.urlStaging}/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> postRegistrasi(
    String email,
    String firstName,
    String lastName,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await _dio.post(
        '${UrlHelper.urlStaging}/register',
        data: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> updateUser(
    String email,
    String firstName,
    String lastName,
    String telepon,
    String password,
  ) async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.put(
        '${UrlHelper.urlStaging}/user',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'phone': telepon,
          'password': password,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> getUser() async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.get(
        '${UrlHelper.urlStaging}/user',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
