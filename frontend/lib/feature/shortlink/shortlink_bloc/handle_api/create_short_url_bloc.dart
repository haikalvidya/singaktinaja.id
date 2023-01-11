import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_create_url.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/create_short_url_event.dart';
part '../state/create_short_url_state.dart';

class CreateShortUrlBloc
    extends Bloc<CreateShortUrlEvent, CreateShortUrlState> {
  final _apiShortUrl = APIServiceShortUrl();
  CreateShortUrlBloc() : super(CreateShortUrlInitial()) {
    on<PostCreateUrl>((event, emit) async {
      emit(CreateShortUrlLoading());
      final result = await _apiShortUrl.createShortUrl(
        event.longUrl ?? '-',
      );
      debugPrint('email: ${event.longUrl}');
      try {
        if (result?.statusCode == 200) {
          debugPrint('success from PostCreateShortUrl');

          emit(CreateShortUrlSuccess(
              responseCreateShortUrl:
                  ResponseCreateUrl.fromJson(result?.data)));
        } else {
          debugPrint(
              'error parsing from PostCreateShortUrl: ${result!.statusCode}');
          emit(
            CreateShortUrlError(
              responseError: ResponseError(
                status: false,
                message: result.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          CreateShortUrlError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
