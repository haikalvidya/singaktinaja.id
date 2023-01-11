part of '../handle_api/get_active_subs_bloc.dart';

abstract class GetActiveSubsEvent extends Equatable {
  const GetActiveSubsEvent();

  @override
  List<Object> get props => [];
}

class GetActiveSubs extends GetActiveSubsEvent {}
