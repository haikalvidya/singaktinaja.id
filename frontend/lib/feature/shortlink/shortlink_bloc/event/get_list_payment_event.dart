part of '../handle_api/get_list_payment_bloc.dart';

abstract class GetListPaymentEvent extends Equatable {
  const GetListPaymentEvent();

  @override
  List<Object> get props => [];
}

class GetListPayment extends GetListPaymentEvent {}
