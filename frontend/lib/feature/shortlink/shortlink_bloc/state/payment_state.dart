part of '../handle_api/payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final ResponsePaymentPaket? responsePayment;
  const PaymentSuccess({this.responsePayment});
}

class PaymentError extends PaymentState {
  final ResponseError? responseError;
  const PaymentError({this.responseError});
}
