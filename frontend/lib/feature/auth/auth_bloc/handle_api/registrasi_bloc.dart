import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_api_service/service_auth.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_model/response_register.dart';
import 'package:flutter_application_singkatin/helper/model_for_handle_error/response_error.dart';

part '../event/registrasi_event.dart';
part '../state/registrasi_state.dart';

class RegistrasiBloc extends Bloc<RegistrasiEvent, RegistrasiState> {
  final APIServiceAuthentication _apiServiceAuthentication =
      APIServiceAuthentication();
  RegistrasiBloc() : super(RegistrasiInitial()) {
    on<PostRegister>((event, emit) async {
      emit(RegistrasiLoading());
      final result = await _apiServiceAuthentication.postRegistrasi(
        event.email ?? '-',
        event.firstName ?? '-',
        event.lastName ?? '-',
        event.password ?? '-',
        event.passwordConfirmation ?? '-',
      );

      try {
        if (result?.statusCode == 200) {
          emit(
            RegistrasiSuccess(
              responseRegistrasi: ResponseRegistrasi.fromJson(result?.data),
            ),
          );
        } else {
          debugPrint('error parsing from PostRegistrasi: ${result!.data}');
          emit(
            RegistrasiError(
              responseError: ResponseError(
                status: false,
                message: "user already exist",
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          RegistrasiError(
              responseError: ResponseError(
            status: false,
            message: result!.data,
          )),
        );
      }
    });
  }
}
