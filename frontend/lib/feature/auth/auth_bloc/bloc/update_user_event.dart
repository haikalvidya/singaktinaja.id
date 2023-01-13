part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {}

class UpdateUser extends UpdateUserEvent {
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? password;

  UpdateUser({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.phone,
  });
  @override
  List<Object?> get props => [email, firstName, lastName, password, phone];
}
