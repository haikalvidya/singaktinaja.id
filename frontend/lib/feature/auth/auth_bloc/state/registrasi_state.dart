part of '../handle_api/registrasi_bloc.dart';

abstract class RegistrasiState extends Equatable {
  const RegistrasiState();

  @override
  List<Object> get props => [];
}

class RegistrasiInitial extends RegistrasiState {}

class RegistrasiLoading extends RegistrasiState {}

class RegistrasiSuccess extends RegistrasiState {
  final ResponseRegistrasi? responseRegistrasi;
  const RegistrasiSuccess({this.responseRegistrasi});
}

class RegistrasiError extends RegistrasiState {
  final ResponseError? responseError;
  const RegistrasiError({this.responseError});
}
