part of '../handle_api/get_list_url_bloc.dart';

abstract class GetListUrlState extends Equatable {
  const GetListUrlState();

  @override
  List<Object> get props => [];
}

class GetListUrlInitial extends GetListUrlState {}

class GetListUrlLoading extends GetListUrlState {}

class GetListUrlSuccess extends GetListUrlState {
  final ResponseGetListUrl? responseGetListUrl;
  const GetListUrlSuccess({this.responseGetListUrl});
}

class GetListUrlError extends GetListUrlState {
  final ResponseError? responseError;
  const GetListUrlError({this.responseError});
}
