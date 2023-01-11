part of '../handle_api/payment_bloc.dart';

abstract class PaymentEvent extends Equatable {}

class PaymentUpgradePaket extends PaymentEvent {
  final String? idPaket;

  PaymentUpgradePaket({this.idPaket});
  @override
  List<Object?> get props => [idPaket];
}
