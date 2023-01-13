// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/bloc/get_user_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/bloc/update_user_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/handle_api/login_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/handle_api/registrasi_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_active_subs_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_list_payment_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/payment_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/create_short_url_auth_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/create_short_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/delete_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_list_url_bloc.dart';

import 'package:flutter_bloc/src/bloc_provider.dart';

class ListBlocProvider {
  static List<BlocProviderSingleChildWidget> getList(BuildContext context) {
    return [
      BlocProvider(create: (BuildContext context) => LoginBloc()),
      BlocProvider(create: (BuildContext context) => RegistrasiBloc()),
      BlocProvider(create: (BuildContext context) => CreateShortUrlAuthBloc()),
      BlocProvider(create: (BuildContext context) => CreateShortUrlBloc()),
      BlocProvider(create: (BuildContext context) => DeleteUrlBloc()),
      BlocProvider(create: (BuildContext context) => GetListUrlBloc()),
      BlocProvider(create: (BuildContext context) => PaymentBloc()),
      BlocProvider(create: (BuildContext context) => GetListPaymentBloc()),
      BlocProvider(create: (BuildContext context) => GetActiveSubsBloc()),
      BlocProvider(create: (BuildContext context) => GetUserBloc()),
      BlocProvider(create: (BuildContext context) => UpdateUserBloc()),
    ];
  }
}
