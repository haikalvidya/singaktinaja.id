part of '../handle_api/get_list_url_bloc.dart';

abstract class GetListUrlEvent extends Equatable {
  const GetListUrlEvent();

  @override
  List<Object> get props => [];
}

class GetShortUrl extends GetListUrlEvent {}
