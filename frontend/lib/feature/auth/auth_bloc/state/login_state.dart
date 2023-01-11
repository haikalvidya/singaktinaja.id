part of '../handle_api/login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final ResponseLogin? responseLogin;
  const LoginSuccess({this.responseLogin});
}

class LoginError extends LoginState {
  final ResponseError? responseError;
  const LoginError({this.responseError});
}
