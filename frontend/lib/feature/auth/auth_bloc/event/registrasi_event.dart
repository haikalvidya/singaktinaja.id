part of '../handle_api/registrasi_bloc.dart';

abstract class RegistrasiEvent extends Equatable {}

class PostRegister extends RegistrasiEvent {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? passwordConfirmation;

  PostRegister({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.passwordConfirmation,
  });
  @override
  List<Object?> get props =>
      [email, firstName, lastName, password, passwordConfirmation];
}
