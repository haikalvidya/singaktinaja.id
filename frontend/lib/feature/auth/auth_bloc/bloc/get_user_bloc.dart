import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_api_service/service_auth.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_model/response_get_user.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final _apiServiceAuthentication = APIServiceAuthentication();

  GetUserBloc() : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoading());
      final result = await _apiServiceAuthentication.getUser();
      debugPrint('error from GetUser: ${result?.statusCode}');

      try {
        if (result!.statusCode! == 200) {
          emit(GetUserSuccess(
              responseGetUser: ResponseGetUser.fromJson(result.data)));
        } else {
          emit(GetUserError(
            responseError: ResponseError(
              status: false,
              message: result.data,
            ),
          ));
        }
      } catch (e) {
        debugPrint('error from GetUser: ${result?.statusCode}');
        emit(
          GetUserError(
            responseError: ResponseError(
              status: false,
              message: result!.statusMessage!,
            ),
          ),
        );
      }
    });
  }
}
