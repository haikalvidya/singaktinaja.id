import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_get_list_payment.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/get_list_payment_event.dart';
part '../state/get_list_payment_state.dart';

class GetListPaymentBloc
    extends Bloc<GetListPaymentEvent, GetListPaymentState> {
  final _apiShortUrl = APIServiceShortUrl();

  GetListPaymentBloc() : super(GetListPaymentInitial()) {
    on<GetListPaymentEvent>((event, emit) async {
      emit(GetListPaymentLoading());
      final result = await _apiShortUrl.getListPayment();
      debugPrint('error from GetListPayment: ${result?.statusCode}');

      try {
        if (result!.statusCode! == 200) {
          emit(GetListPaymentSuccess(
              responseGetListPayment:
                  ResponseGetListPayment.fromJson(result.data)));
        } else {
          emit(GetListPaymentError(
            responseError: ResponseError(
              status: false,
              message: result.data,
            ),
          ));
        }
      } catch (e) {
        debugPrint('error from GetListPayment: ${result?.statusCode}');
        emit(
          GetListPaymentError(
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
