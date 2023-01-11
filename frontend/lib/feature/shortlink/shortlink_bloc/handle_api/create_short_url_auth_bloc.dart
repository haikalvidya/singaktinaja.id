import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_create_url_auth.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/create_short_url_auth_event.dart';
part '../state/create_short_url_auth_state.dart';

class CreateShortUrlAuthBloc
    extends Bloc<CreateShortUrlAuthEvent, CreateShortUrlAuthState> {
  final _apiShortUrl = APIServiceShortUrl();
  CreateShortUrlAuthBloc() : super(CreateShortUrlAuthInitial()) {
    on<PostCreateUrlAuth>((event, emit) async {
      emit(CreateShortUrlAuthLoading());
      final result = await _apiShortUrl.createShortUrlAuthorized(
        event.longUrl ?? '-',
        event.name ?? '-',
        event.shortUrl ?? '-',
      );
      debugPrint('email: ${event.longUrl}');
      debugPrint('password: ${event.name}');
      debugPrint('password: ${event.shortUrl}');

      try {
        if (result?.statusCode == 200) {
          debugPrint('success from PostCreateShortUrlAuth');

          emit(CreateShortUrlAuthSuccess(
              responseCreateShortUrlAuth:
                  ResponseCreateShortUrlAuth.fromJson(result?.data)));
        } else {
          debugPrint(
              'error parsing from PostCreateShortUrlAuth: ${result!.statusCode}');
          emit(
            CreateShortUrlAuthError(
              responseError: ResponseError(
                status: false,
                message: result.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          CreateShortUrlAuthError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
