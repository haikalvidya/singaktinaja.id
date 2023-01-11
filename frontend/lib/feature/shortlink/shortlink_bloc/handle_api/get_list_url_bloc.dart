import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_list_url.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/get_list_url_event.dart';
part '../state/get_list_url_state.dart';

class GetListUrlBloc extends Bloc<GetListUrlEvent, GetListUrlState> {
  final _apiShortUrl = APIServiceShortUrl();

  GetListUrlBloc() : super(GetListUrlInitial()) {
    on<GetListUrlEvent>((event, emit) async {
      emit(GetListUrlLoading());
      final result = await _apiShortUrl.getShortUrl();
      debugPrint('error from getListUrl: ${result?.statusCode}');

      try {
        if (result!.statusCode! == 200) {
          emit(GetListUrlSuccess(
              responseGetListUrl: ResponseGetListUrl.fromJson(result.data)));
        } else {
          emit(GetListUrlError(
            responseError: ResponseError(
              status: false,
              message: result.data,
            ),
          ));
        }
      } catch (e) {
        debugPrint('error from getListUrl: ${result?.statusCode}');
        emit(
          GetListUrlError(
            responseError: ResponseError(
              status: false,
              message: result!.statusMessage!,
            ),
          ),
        );
      }
    });
  }
}
