part of '../handle_api/create_short_url_bloc.dart';

abstract class CreateShortUrlEvent extends Equatable {}

class PostCreateUrl extends CreateShortUrlEvent {
  final String? longUrl;

  PostCreateUrl({this.longUrl});
  @override
  List<Object?> get props => [longUrl];
}
