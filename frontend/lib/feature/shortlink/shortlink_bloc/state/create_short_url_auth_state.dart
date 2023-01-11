part of '../handle_api/create_short_url_auth_bloc.dart';

abstract class CreateShortUrlAuthState extends Equatable {
  const CreateShortUrlAuthState();

  @override
  List<Object> get props => [];
}

class CreateShortUrlAuthInitial extends CreateShortUrlAuthState {}

class CreateShortUrlAuthLoading extends CreateShortUrlAuthState {}

class CreateShortUrlAuthSuccess extends CreateShortUrlAuthState {
  final ResponseCreateShortUrlAuth? responseCreateShortUrlAuth;
  const CreateShortUrlAuthSuccess({this.responseCreateShortUrlAuth});
}

class CreateShortUrlAuthError extends CreateShortUrlAuthState {
  final ResponseError? responseError;
  const CreateShortUrlAuthError({this.responseError});
}
