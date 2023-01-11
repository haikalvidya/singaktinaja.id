part of '../handle_api/get_list_payment_bloc.dart';

abstract class GetListPaymentState extends Equatable {
  const GetListPaymentState();

  @override
  List<Object> get props => [];
}

class GetListPaymentInitial extends GetListPaymentState {}

class GetListPaymentLoading extends GetListPaymentState {}

class GetListPaymentSuccess extends GetListPaymentState {
  final ResponseGetListPayment? responseGetListPayment;
  const GetListPaymentSuccess({this.responseGetListPayment});
}

class GetListPaymentError extends GetListPaymentState {
  final ResponseError? responseError;
  const GetListPaymentError({this.responseError});
}
