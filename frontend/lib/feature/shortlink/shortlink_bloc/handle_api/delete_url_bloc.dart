import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_delete.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/delete_url_event.dart';
part '../state/delete_url_state.dart';

class DeleteUrlBloc extends Bloc<DeleteUrlEvent, DeleteUrlState> {
  final _apiShortUrl = APIServiceShortUrl();

  DeleteUrlBloc() : super(DeleteUrlInitial()) {
    on<PostDeleteUrl>((event, emit) async {
      emit(DeleteUrlLoading());
      final result = await _apiShortUrl.deleteUrl(
        event.idUrl ?? '-',
      );
      debugPrint('email: ${event.idUrl}');
      try {
        if (result?.statusCode == 200) {
          debugPrint('success from PostDeleteUrl');

          emit(DeleteUrlSuccess(
              responseDeleteUrl: ResponseDeleteUrl.fromJson(result?.data)));
        } else {
          debugPrint('error parsing from PostDeleteUrl: ${result!.statusCode}');
          emit(
            DeleteUrlError(
              responseError: ResponseError(
                status: false,
                message: result.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          DeleteUrlError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
