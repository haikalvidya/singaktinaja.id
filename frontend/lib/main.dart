import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/login_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/home_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/home_unauthorized_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/list_bloc_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helper/token_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ListBlocProvider.getList(context),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  static const String splashPage = 'splash';
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      final TokenHelper _tokenHelper = TokenHelper();
      String token = await _tokenHelper.getToken();
      if (token.isEmpty) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeUnAuthorizedPage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.backgroundGrey,
      body: Center(
          child: Text(
        'ShortLink',
        style: GoogleFonts.montserrat(),
      )),
    );
  }
}
