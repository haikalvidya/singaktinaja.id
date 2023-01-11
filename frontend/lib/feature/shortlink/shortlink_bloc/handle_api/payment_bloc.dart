import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_api_service/service_shortlink.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_create_url.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_model/response_payment.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/payment_event.dart';
part '../state/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final _apiShortUrl = APIServiceShortUrl();

  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentUpgradePaket>((event, emit) async {
      emit(PaymentLoading());
      final result = await _apiShortUrl.paymentUpgradePaket(
        event.idPaket ?? '-',
      );
      debugPrint('email: ${event.idPaket}');
      try {
        if (result?.statusCode == 200) {
          debugPrint('success from PostPayment');

          emit(PaymentSuccess(
              responsePayment: ResponsePaymentPaket.fromJson(result?.data)));
        } else {
          debugPrint('error parsing from PostPayment: ${result!.statusCode}');
          emit(
            PaymentError(
              responseError: ResponseError(
                status: false,
                message: result.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          PaymentError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
