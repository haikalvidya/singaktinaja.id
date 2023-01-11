part of '../handle_api/create_short_url_bloc.dart';

abstract class CreateShortUrlState extends Equatable {
  const CreateShortUrlState();

  @override
  List<Object> get props => [];
}

class CreateShortUrlInitial extends CreateShortUrlState {}

class CreateShortUrlLoading extends CreateShortUrlState {}

class CreateShortUrlSuccess extends CreateShortUrlState {
  final ResponseCreateUrl? responseCreateShortUrl;
  const CreateShortUrlSuccess({this.responseCreateShortUrl});
}

class CreateShortUrlError extends CreateShortUrlState {
  final ResponseError? responseError;
  const CreateShortUrlError({this.responseError});
}
