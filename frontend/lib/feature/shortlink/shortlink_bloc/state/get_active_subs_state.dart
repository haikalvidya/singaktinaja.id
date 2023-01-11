part of '../handle_api/get_active_subs_bloc.dart';

abstract class GetActiveSubsState extends Equatable {
  const GetActiveSubsState();

  @override
  List<Object> get props => [];
}

class GetActiveSubsInitial extends GetActiveSubsState {}

class GetActiveSubsLoading extends GetActiveSubsState {}

class GetActiveSubsSuccess extends GetActiveSubsState {
  final ResponseGetActiveSubscription? responseGetActiveSubs;
  const GetActiveSubsSuccess({this.responseGetActiveSubs});
}

class GetActiveSubsError extends GetActiveSubsState {
  final ResponseError? responseError;
  const GetActiveSubsError({this.responseError});
}
