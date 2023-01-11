part of '../handle_api/delete_url_bloc.dart';

abstract class DeleteUrlState extends Equatable {
  const DeleteUrlState();

  @override
  List<Object> get props => [];
}

class DeleteUrlInitial extends DeleteUrlState {}

class DeleteUrlLoading extends DeleteUrlState {}

class DeleteUrlSuccess extends DeleteUrlState {
  final ResponseDeleteUrl? responseDeleteUrl;
  const DeleteUrlSuccess({this.responseDeleteUrl});
}

class DeleteUrlError extends DeleteUrlState {
  final ResponseError? responseError;
  const DeleteUrlError({this.responseError});
}
