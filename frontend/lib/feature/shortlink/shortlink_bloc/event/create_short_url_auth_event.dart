part of '../handle_api/create_short_url_auth_bloc.dart';

abstract class CreateShortUrlAuthEvent extends Equatable {}

class PostCreateUrlAuth extends CreateShortUrlAuthEvent {
  final String? longUrl;
  final String? name;
  final String? shortUrl;

  PostCreateUrlAuth({this.longUrl, this.name, this.shortUrl});
  @override
  List<Object?> get props => [longUrl, name, shortUrl];
}
