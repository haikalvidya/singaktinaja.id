import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_api_service/service_auth.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_model/response_login.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

import '../event/login_event.dart';

part '../state/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _apiServiceAuthentication = APIServiceAuthentication();
  LoginBloc() : super(LoginInitial()) {
    on<PostLogin>((event, emit) async {
      emit(LoginLoading());
      final result = await _apiServiceAuthentication.postLogin(
        event.email ?? '-',
        event.password ?? '-',
      );
      debugPrint('email: ${event.email}');
      debugPrint('password: ${event.password}');
      try {
        if (result?.statusCode == 200) {
          debugPrint('success from PostLogin');

          emit(LoginSuccess(
              responseLogin: ResponseLogin.fromJson(result?.data)));
        } else {
          debugPrint('error parsing from PostLogin: ${result!.statusCode}');
          emit(
            LoginError(
              responseError: ResponseError(
                status: false,
                message: result.data,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          LoginError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
