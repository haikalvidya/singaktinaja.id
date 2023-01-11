part of '../handle_api/delete_url_bloc.dart';

abstract class DeleteUrlEvent extends Equatable {}

class PostDeleteUrl extends DeleteUrlEvent {
  final String? idUrl;

  PostDeleteUrl({this.idUrl});
  @override
  List<Object?> get props => [idUrl];
}
