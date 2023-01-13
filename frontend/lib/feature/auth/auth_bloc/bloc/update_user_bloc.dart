import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_api_service/service_auth.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_model/response_update.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  UpdateUserBloc() : super(UpdateUserInitial()) {
    final _apiServiceAuthentication = APIServiceAuthentication();

    on<UpdateUser>((event, emit) async {
      emit(UpdateUserLoading());
      final result = await _apiServiceAuthentication.updateUser(
        event.email ?? '-',
        event.firstName ?? '-',
        event.lastName ?? '-',
        event.phone ?? '-',
        event.password ?? '-',
      );

      try {
        if (result?.statusCode == 200) {
          emit(
            UpdateUserSuccess(
              responseUpdateUser: ResponseUpdateUser.fromJson(result?.data),
            ),
          );
        } else {
          debugPrint('error parsing from PostUpdateUser: ${result!.data}');
          emit(
            UpdateUserError(
              responseError: ResponseError(
                status: false,
                message: "user already exist",
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          UpdateUserError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
