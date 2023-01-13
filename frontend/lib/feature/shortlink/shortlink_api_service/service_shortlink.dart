import 'package:dio/dio.dart';
import 'package:flutter_application_singkatin/helper/token_helper.dart';
import 'package:flutter_application_singkatin/helper/url_helper.dart';

class APIServiceShortUrl {
  final Dio _dio = Dio();
  final TokenHelper _tokenHelper = TokenHelper();

  Future<Response<dynamic>?> createShortUrlAuthorized(
    String longUrl,
    String name,
    String shortUrl,
  ) async {
    String token = await _tokenHelper.getToken();

    try {
      final response = await _dio.post(
        '${UrlHelper.urlStaging}/short-url',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: {
          'long_url': longUrl,
          'name': name,
          'short_url': shortUrl,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> createShortUrl(
    String longUrl,
  ) async {
    try {
      final response = await _dio.post(
        '${UrlHelper.urlStaging}/singkatin',
        data: {
          'long_url': longUrl,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> deleteUrl(
    String id,
  ) async {
    try {
      final response =
          await _dio.delete('${UrlHelper.urlStaging}/short-url/$id');
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response<dynamic>?> getShortUrl() async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.get(
        '${UrlHelper.urlStaging}/short-url',
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

  Future<Response<dynamic>?> getActiveSubscription() async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.get(
        '${UrlHelper.urlStaging}/subscription',
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

  Future<Response<dynamic>?> getListPayment() async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.get(
        '${UrlHelper.urlStaging}/payment',
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

  Future<Response<dynamic>?> paymentUpgradePaket(String idPaket) async {
    try {
      String token = await _tokenHelper.getToken();

      final response = await _dio.post(
        '${UrlHelper.urlStaging}/subscription',
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: {
          "jenis_paket_id": idPaket,
        },
      );
      print("Debug Print ${response.statusCode}");

      return response;
    } on DioError catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
