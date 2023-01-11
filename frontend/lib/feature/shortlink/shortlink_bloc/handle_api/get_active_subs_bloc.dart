import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_get_active_subscription.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/get_active_subs_event.dart';
part '../state/get_active_subs_state.dart';

class GetActiveSubsBloc extends Bloc<GetActiveSubsEvent, GetActiveSubsState> {
  final _apiShortUrl = APIServiceShortUrl();

  GetActiveSubsBloc() : super(GetActiveSubsInitial()) {
    on<GetActiveSubsEvent>((event, emit) async {
      emit(GetActiveSubsLoading());
      final result = await _apiShortUrl.getActiveSubscription();
      debugPrint('error from GetActiveSubs: ${result?.statusCode}');

      try {
        if (result!.statusCode! == 200) {
          emit(GetActiveSubsSuccess(
              responseGetActiveSubs:
                  ResponseGetActiveSubscription.fromJson(result.data)));
        } else {
          emit(GetActiveSubsError(
            responseError: ResponseError(
              status: false,
              message: result.data,
            ),
          ));
        }
      } catch (e) {
        debugPrint('error from GetActiveSubs: ${result?.statusCode}');
        emit(
          GetActiveSubsError(
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
