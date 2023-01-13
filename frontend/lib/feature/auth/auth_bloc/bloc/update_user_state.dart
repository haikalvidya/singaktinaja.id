part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final ResponseUpdateUser? responseUpdateUser;
  const UpdateUserSuccess({this.responseUpdateUser});
}

class UpdateUserError extends UpdateUserState {
  final ResponseError? responseError;
  const UpdateUserError({this.responseError});
}
