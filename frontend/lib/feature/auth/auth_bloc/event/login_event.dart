import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class PostLogin extends LoginEvent {
  final String? email;
  final String? password;

  PostLogin({this.email, this.password});
  @override
  List<Object?> get props => [email, password];
}
