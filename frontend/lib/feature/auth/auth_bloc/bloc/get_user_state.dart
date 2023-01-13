part of 'get_user_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserSuccess extends GetUserState {
  final ResponseGetUser? responseGetUser;
  const GetUserSuccess({this.responseGetUser});
}

class GetUserError extends GetUserState {
  final ResponseError? responseError;
  const GetUserError({this.responseError});
}
